import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthy_fit/core/api/end_points.dart';
import 'package:healthy_fit/core/api/exceptions.dart';
import 'package:healthy_fit/core/routes/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/api/api_consumer.dart';
import '../../../core/cache/cache_helper.dart';
import '../../../core/routes/functions/navigation_functions.dart';
import '../data/food_model/food_model/food_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiConsumer api;
  HomeCubit(this.api) : super(GoalsInitial());

  late int calorieGoal;
  int myCalories = 0;
  int myProtein = 0;
  int myCarbs = 0;
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

  fetchFood(context) async {
    emit(GetFoodsLoading());
    final token = await CacheHelper.getSecuredString(key: ApiKeys.token);
    final userId = CacheHelper.getData(key: ApiKeys.id);
    debugPrint("Your Id Is $userId");
    try {
      final response = await api
          .get(ApiKeys.food, headers: {'Authorization': 'Bearer $token'});
      foodItems =
          (response as List).map((item) => FoodModel.fromJson(item)).toList();
      myFood = foodItems.where((food) => food.createdBy!.id == userId).toList();
      debugPrint("Your food is ${myFood.length}");

      emit(GetFoodsLoaded(foodItems: foodItems));
    } on ServerException catch (e) {
      if (e.errModel.errorMessage == "Not authorized, token failed") {
        await CacheHelper.removeSecuredString(key: ApiKeys.token);
        customReplacementAndRemove(context, login);
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

  void updateNutrition(
    int calories,
    int protein,
    int carbs,
  ) async {
    final userId = CacheHelper.getData(key: ApiKeys.id);
    if (userId == null) return;

    var box = Hive.box('nutritionBox');
      await checkForMidnightReset(userId); 

    final calorieKey = 'myCalories_$userId';
    final proteinKey = 'myProtein_$userId';
    final carbsKey = 'myCarbs_$userId';

    // Update calories
    int myCalories = box.get(calorieKey, defaultValue: 0);
    myCalories += calories;
    if (myCalories > calorieGoal) myCalories = calorieGoal;
    box.put(calorieKey, myCalories);

    int myProtein = box.get(proteinKey, defaultValue: 0);
    myProtein += protein;
    box.put(proteinKey, myProtein);

    int myCarbs = box.get(carbsKey, defaultValue: 0);
    myCarbs += carbs;
    box.put(carbsKey, myCarbs);


    await _updateWeeklyNutrition(
      userId,
      myCalories,
      myProtein,
      myCarbs,
    );

    emit(UpdateNutritionGoal(
      myCalories: myCalories,
      myProtein: myProtein,
      myCarbs: myCarbs,
    ));

    // ✅ Fetch and update the weekly nutrition data
    await fetchWeeklyNutrition();
  }

  Future<void> _updateWeeklyNutrition(
      String userId, int myCalories, int myProtein, int myCarbs) async {
    var box = Hive.box('nutritionBox');
    List<int> weeklyCalories =
        box.get('weeklyCalories_$userId', defaultValue: List.filled(7, 0));
    List<int> weeklyProtein =
        box.get('weeklyProtein_$userId', defaultValue: List.filled(7, 0));
    List<int> weeklyCarbs =
        box.get('weeklyCarbs_$userId', defaultValue: List.filled(7, 0));

    DateTime now = DateTime.now();
    int weekdayIndex = now.weekday - 1; // Monday = 0, Sunday = 6

    // ✅ Update the current day's nutrition
    weeklyCalories[weekdayIndex] = myCalories;
    weeklyProtein[weekdayIndex] = myProtein;
    weeklyCarbs[weekdayIndex] = myCarbs;

    // ✅ Save the updated weekly nutrition back to Hive
    box.put('weeklyCalories_$userId', weeklyCalories);
    box.put('weeklyProtein_$userId', weeklyProtein);
    box.put('weeklyCarbs_$userId', weeklyCarbs);
  }

  Future<void> fetchWeeklyNutrition() async {
    emit(GetWeeklyNutritionLoading());
    try {
      var box = Hive.box('nutritionBox');
      final userId = CacheHelper.getData(key: ApiKeys.id);
      if (userId == null) {
        emit(GetWeeklyNutritionFailure(errMsg: "User ID is null."));
        return;
      }

      await checkForMidnightReset(userId); 
      List<int> weeklyCalories =
          box.get('weeklyCalories_$userId', defaultValue: List.filled(7, 0));
      List<int> weeklyProtein =
          box.get('weeklyProtein_$userId', defaultValue: List.filled(7, 0));
      List<int> weeklyCarbs =
          box.get('weeklyCarbs_$userId', defaultValue: List.filled(7, 0));

      debugPrint("Fetched Weekly Calories: $weeklyCalories");
      debugPrint("Fetched Weekly Protein: $weeklyProtein");
      debugPrint("Fetched Weekly Carbs: $weeklyCarbs");

      List<double> weeklyCaloriesInDouble =
          weeklyCalories.map((e) => e.toDouble()).toList();
      List<double> weeklyProteinInDouble =
          weeklyProtein.map((e) => e.toDouble()).toList();
      List<double> weeklyCarbsInDouble =
          weeklyCarbs.map((e) => e.toDouble()).toList();

      emit(GetWeeklyNutritionSuccess(
        weeklyCalories: weeklyCaloriesInDouble,
        weeklyProtein: weeklyProteinInDouble,
        weeklyCarbs: weeklyCarbsInDouble,
      ));
    } catch (e) {
      emit(GetWeeklyNutritionFailure(errMsg: e.toString()));
    }
  }

  Future<void> checkForMidnightReset(String userId) async {
    DateTime now = DateTime.now();
    String todayDate = "${now.year}-${now.month}-${now.day}";

    var box = Hive.box('nutritionBox');

    String? lastResetDate = box.get('lastResetDate_$userId');

    if (lastResetDate != todayDate) {
      List<int> weeklyCalories =
          box.get('weeklyCalories_$userId', defaultValue: List.filled(7, 0));
      List<int> weeklyProtein =
          box.get('weeklyProtein_$userId', defaultValue: List.filled(7, 0));
      List<int> weeklyCarbs =
          box.get('weeklyCarbs_$userId', defaultValue: List.filled(7, 0));

      int weekdayIndex = now.weekday - 1; // Monday = 0, Sunday = 6

      // ✅ Store today's nutrition
      weeklyCalories[weekdayIndex] = myCalories;
      weeklyProtein[weekdayIndex] = myProtein;
      weeklyCarbs[weekdayIndex] = myCarbs;

      // ✅ Save the updated weekly nutrition
      box.put('weeklyCalories_$userId', weeklyCalories);
      box.put('weeklyProtein_$userId', weeklyProtein);
      box.put('weeklyCarbs_$userId', weeklyCarbs);

      // ✅ Reset daily nutrition
      box.put('myCalories_$userId', 0);
      box.put('myProtein_$userId', 0);
      box.put('myCarbs_$userId', 0);
      box.put('lastResetDate_$userId', todayDate);

      // If it's Monday, reset the entire weekly data
      if (weekdayIndex == 0) {
        box.put('weeklyCalories_$userId', List.filled(7, 0));
        box.put('weeklyProtein_$userId', List.filled(7, 0));
        box.put('weeklyCarbs_$userId', List.filled(7, 0));
      }
    }
  }
}
