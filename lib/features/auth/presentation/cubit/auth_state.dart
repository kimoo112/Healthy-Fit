part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthStateUpdated extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {
  final String errorMessage;
  LoginFailure(this.errorMessage);
}

class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {}

class SignUpFailure extends AuthState {
  final String errorMessage;
  SignUpFailure(this.errorMessage);
}

// Goal Selection States
class GoalSelected extends AuthState {
  final int selectedGoal;
  GoalSelected(this.selectedGoal);
}

class GoalLoading extends AuthState {}

class GoalSuccess extends AuthState {
  final int calorieGoal;
  GoalSuccess(this.calorieGoal);
}

class GoalFailure extends AuthState {
  final String error;
  GoalFailure(this.error);
}
