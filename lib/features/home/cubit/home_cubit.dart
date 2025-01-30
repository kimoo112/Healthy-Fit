import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthy_fit/core/api/end_points.dart';
import 'package:healthy_fit/core/api/exceptions.dart';
import 'package:healthy_fit/features/home/data/food_model/food_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
      debugPrint("Calories Goal Cache: $cachedCalorieGoal");
      emit(GetCaloriesGoalSuccess(calorieGoal: calorieGoal));
      return;
    }
    final token = await CacheHelper.getSecuredString(key: ApiKeys.token);
    try {
      final response = await api
          .get(ApiKeys.goals, headers: {'Authorization': 'Bearer $token'});
      calorieGoal = response[ApiKeys.caloriesGoal];
      await CacheHelper.saveData(key: ApiKeys.caloriesGoal, value: calorieGoal);
      debugPrint("Calories Goal Cache: $calorieGoal");
      emit(GetCaloriesGoalSuccess(calorieGoal: calorieGoal));
    } on ServerException catch (e) {
      emit(GetCaloriesGoalFailure(errMsg: e.errModel.errorMessage));
    }
  }

  fetchFood() async {
    emit(GetFoodsLoading());
    final token = await CacheHelper.getSecuredString(key: ApiKeys.token);
    final userId = CacheHelper.getData(key: ApiKeys.id);
    debugPrint("Your Id Is $userId");
    try {
      final response = await api
          .get(ApiKeys.food, headers: {'Authorization': 'Bearer $token'});
      foodItems =
          (response as List).map((item) => FoodModel.fromJson(item)).toList();
      myFood =
          foodItems.where((food) => food.createdBy['_id'] == userId).toList();
      debugPrint("Your food is ${myFood.length}");

      emit(GetFoodsLoaded(foodItems: foodItems));
    } on ServerException catch (e) {
      if (e.errModel.errorMessage == "Not authorized, token failed") {
        // Check if error is 401 Unauthorized
        await CacheHelper.removeSecuredString(key: ApiKeys.token);
      }
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
      if (token == null) {
        throw Exception("Token is null");
      }
      await api.delete(
        "${ApiKeys.food}/$id",
        headers: {
          'Authorization': 'Bearer $token',
        },
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
  final userId = CacheHelper.getData(key: ApiKeys.id);
  if (userId == null) return;

  var box = Hive.box('caloriesBox');
  final calorieKey = 'myCalories_$userId';

  int myCalories = box.get(calorieKey, defaultValue: 0);
  myCalories += calories;

  if (myCalories > calorieGoal) myCalories = calorieGoal;

  box.put(calorieKey, myCalories);

  // ✅ Update the weekly calories data
  await _updateWeeklyCalories(userId, myCalories);

  emit(UpdateCaloriesGoal(myCalories: myCalories));

  // ✅ Fetch and update the weekly calories data
  await fetchWeeklyCalories();
}

Future<void> _updateWeeklyCalories(String userId, int myCalories) async {
  var box = Hive.box('caloriesBox');
  List<int> weeklyCalories =
      box.get('weeklyCalories_$userId', defaultValue: List.filled(7, 0));

  DateTime now = DateTime.now();
  int weekdayIndex = now.weekday - 1; // Monday = 0, Sunday = 6

  // ✅ Update the current day's calories
  weeklyCalories[weekdayIndex] = myCalories;

  // ✅ Save the updated weekly calories back to Hive
  box.put('weeklyCalories_$userId', weeklyCalories);
} 

  Future<void> _checkForMidnightReset(String userId) async {
    DateTime now = DateTime.now();
    String todayDate = "${now.year}-${now.month}-${now.day}";

    var box = Hive.box('caloriesBox');

    String? lastResetDate = box.get('lastResetDate_$userId');

    if (lastResetDate != todayDate) {
      List<int> weeklyCalories =
          box.get('weeklyCalories_$userId', defaultValue: List.filled(7, 0));

      int weekdayIndex = now.weekday - 1; // Monday = 0, Sunday = 6
      weeklyCalories[weekdayIndex] = myCalories; // Store today's calories

      box.put('weeklyCalories_$userId', weeklyCalories);
      box.put('lastResetDate_$userId', todayDate);
      box.put('myCalories_$userId', 0); // Reset daily calories after storing

      // If it's Monday, reset the entire weekly data
      if (weekdayIndex == 0) {
        box.put('weeklyCalories_$userId', List.filled(7, 0));
      }
    }
  }
Future<void> fetchWeeklyCalories() async {
  emit(GetWeeklyCaloriesLoading());
  try {
    var box = Hive.box('caloriesBox');
    final userId = CacheHelper.getData(key: ApiKeys.id);
    if (userId == null) {
      emit(GetWeeklyCaloriesFailure(errMsg: "User ID is null."));
      return;
    }

    await _checkForMidnightReset(userId); // ✅ Ensure data is reset if needed
    List<int> weeklyCalories =
        box.get('weeklyCalories_$userId', defaultValue: List.filled(7, 0));
    debugPrint("Fetched Weekly Calories: $weeklyCalories");

    List<double> weeklyCaloriesInDouble =
        weeklyCalories.map((e) => e.toDouble()).toList();
    emit(GetWeeklyCaloriesSuccess(weeklyCalories: weeklyCaloriesInDouble));
  } catch (e) {
    emit(GetWeeklyCaloriesFailure(errMsg: e.toString()));
  }
}
}