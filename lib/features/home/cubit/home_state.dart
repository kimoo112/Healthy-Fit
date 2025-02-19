part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class GoalsInitial extends HomeState {}

final class GetCaloriesGoalLoading extends HomeState {}

final class GetCaloriesGoalSuccess extends HomeState {
  final int calorieGoal;

  GetCaloriesGoalSuccess({required this.calorieGoal});
}

final class GetCaloriesGoalFailure extends HomeState {
  final String errMsg;

  GetCaloriesGoalFailure({required this.errMsg});
}

final class GetFoodsLoading extends HomeState {}

final class GetFoodsLoaded extends HomeState {
  final List<FoodModel> foodItems;

  GetFoodsLoaded({required this.foodItems});
}

final class GetFoodsFailure extends HomeState {
  final String errMsg;

  GetFoodsFailure({required this.errMsg});
}

final class AddFoodsLoading extends HomeState {}

final class AddFoodsSuccessful extends HomeState {}

final class AddFoodsFailure extends HomeState {
  final String errMsg;

  AddFoodsFailure({required this.errMsg});
}

final class UpdateNutritionGoal extends HomeState {
  final int myCalories;
  final int myProtein;
  final int myCarbs;

  UpdateNutritionGoal({
    required this.myCalories,
    required this.myProtein,
    required this.myCarbs,
  });
}

final class DeleteFoodLoading extends HomeState {}

final class DeleteFoodSuccessful extends HomeState {}

final class DeleteFoodFailure extends HomeState {
  final String errorMessage;

  DeleteFoodFailure({required this.errorMessage});
}

class GetWeeklyNutritionLoading extends HomeState {}

class GetWeeklyNutritionSuccess extends HomeState {
  final List<double> weeklyCalories;
  final List<double> weeklyProtein;
  final List<double> weeklyCarbs;

  GetWeeklyNutritionSuccess({
    required this.weeklyCalories,
    required this.weeklyProtein,
    required this.weeklyCarbs,
  });
}

class GetWeeklyNutritionFailure extends HomeState {
  final String errMsg;

  GetWeeklyNutritionFailure({required this.errMsg});
}