import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthy_fit/core/api/end_points.dart';
import 'package:healthy_fit/core/api/exceptions.dart';
import 'package:healthy_fit/features/home/data/food_model/food_model.dart';

import '../../../core/api/api_consumer.dart';
import '../../../core/cache/cache_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiConsumer api;
  HomeCubit(this.api) : super(GoalsInitial());

  late int calorieGoal;
  int myCalories = 0;
  List<FoodModel> foodItems = [];
  List<FoodModel> myFood = [];
  TextEditingController meal = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController calories = TextEditingController();

  fetchCaloriesGoals() async {
    emit(GetCaloriesGoalLoading());
    final cachedCalorieGoal = CacheHelper.getData(key: ApiKeys.caloriesGoal);
    if (cachedCalorieGoal != null) {
      calorieGoal = cachedCalorieGoal;
      debugPrint(
          " Calories Goal Cache ${CacheHelper.getData(key: ApiKeys.caloriesGoal)}");
      emit(GetCaloriesGoalSuccess(calorieGoal: calorieGoal));
      return;
    }
    final token = await CacheHelper.getSecuredString(key: ApiKeys.token);
    try {
      final response = await api
          .get(ApiKeys.goals, headers: {'Authorization': 'Bearer $token'});
      calorieGoal = response[ApiKeys.caloriesGoal];
      await CacheHelper.saveData(key: ApiKeys.caloriesGoal, value: calorieGoal);
      debugPrint(
          " Calories Goal Cache ${CacheHelper.getData(key: ApiKeys.caloriesGoal)}");
      emit(GetCaloriesGoalSuccess(calorieGoal: calorieGoal));
    } on ServerException catch (e) {
      emit(GetCaloriesGoalFailure(errMsg: e.errModel.errorMessage));
    }
  }

  fetchFood() async {
    emit(GetFoodsLoading());
    final token = await CacheHelper.getSecuredString(key: ApiKeys.token);
    final userId = CacheHelper.getData(key: ApiKeys.id);
    debugPrint(" YOur Id Is $userId");
    try {
      final response = await api
          .get(ApiKeys.food, headers: {'Authorization': 'Bearer $token'});
      foodItems =
          (response as List).map((item) => FoodModel.fromJson(item)).toList();
      myFood =
          foodItems.where((food) => food.createdBy['_id'] == userId).toList();
      debugPrint(" Your food is ${myFood.length}");

      emit(GetFoodsLoaded(foodItems: foodItems));
    } on ServerException catch (e) {
      emit(GetFoodsFailure(errMsg: e.errModel.errorMessage));
    }
  }

  addFood() async {
    emit(AddFoodsLoading());
    try {
      final token = await CacheHelper.getSecuredString(key: ApiKeys.token);
      final response = await api.post(ApiKeys.food, data: {
        ApiKeys.name: meal.text,
        ApiKeys.category: category.text,
        ApiKeys.calories: calories.text,
        ApiKeys.createdBy: CacheHelper.getData(key: ApiKeys.id)
      }, headers: {
        'Authorization': 'Bearer $token'
      });
      final newFood = FoodModel.fromJson(response);

      myFood.add(newFood);
      emit(AddFoodsSuccessful());
      meal.clear();
      category.clear();
      calories.clear();
    } on ServerException catch (e) {
      emit(AddFoodsFailure(errMsg: e.errModel.errorMessage));
    }
  }

 deleteAddedFood(final String id) async {
  emit(DeleteFoodLoading());

  try {
    final token = await CacheHelper.getSecuredString(key: ApiKeys.token);

    debugPrint("Delete URL: ${ApiKeys.food}/$id");
    debugPrint("Token: $token");

    if (token == null) {
      throw Exception("Token is null");
    }

    await api.delete(
      "${ApiKeys.food}/$id",
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      data: null, // Explicitly pass `null` for data to ensure no issues.
    );

    debugPrint("Food with ID $id deleted successfully.");
    emit(DeleteFoodSuccessful());
  } catch (e) {
    debugPrint("Delete Error: $e");
    if (e is ServerException) {
      emit(DeleteFoodFailure(errorMessage: e.errModel.errorMessage));
    } else {
      emit(DeleteFoodFailure(errorMessage: e.toString()));
    }
  }
}

  void updateCalories(int calories) async {
    myCalories = await CacheHelper.getData(key: 'myCalories') ?? 0;
    myCalories += calories;

    if (myCalories > calorieGoal) {
      myCalories = calorieGoal;
    }

    await CacheHelper.saveData(key: 'myCalories', value: myCalories);

    await _checkForMidnightReset();

    emit(UpdateCaloriesGoal(myCalories: myCalories));
  }

  Future<void> _checkForMidnightReset() async {
    DateTime now = DateTime.now();
    String todayDate = "${now.year}-${now.month}-${now.day}";

    String? lastResetDate = await CacheHelper.getData(key: 'lastResetDate');

    if (lastResetDate != todayDate) {
      List<int> weeklyCalories =
          await CacheHelper.getData(key: 'weeklyCalories')?.cast<int>() ??
              List.filled(7, 0);
      int weekdayIndex = now.weekday - 1;
      weeklyCalories[weekdayIndex] = myCalories;

      await CacheHelper.saveData(key: 'weeklyCalories', value: weeklyCalories);

      myCalories = 0;
      await CacheHelper.saveData(key: 'myCalories', value: myCalories);

      await CacheHelper.saveData(key: 'lastResetDate', value: todayDate);
      if (weekdayIndex == 0) {
        await CacheHelper.saveData(
            key: 'weeklyCalories', value: List.filled(7, 0));
      }
    }
  }

  Future<List<int>> getWeeklyCalories() async {
    return await CacheHelper.getData(key: 'weeklyCalories')?.cast<int>() ??
        List.filled(7, 0);
  }
}
