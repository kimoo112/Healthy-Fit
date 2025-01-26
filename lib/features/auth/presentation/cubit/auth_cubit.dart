import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:healthy_fit/core/api/api_consumer.dart';
import 'package:healthy_fit/core/api/end_points.dart';
import 'package:healthy_fit/core/cache/cache_helper.dart';
import 'package:healthy_fit/features/auth/data/models/user/user.dart';

import '../../../../core/api/exceptions.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ApiConsumer api;
  AuthCubit(this.api) : super(AuthInitial());

  final TextEditingController loginEmail = TextEditingController();
  final TextEditingController loginPassword = TextEditingController();
  final TextEditingController signupName = TextEditingController();
  final TextEditingController signupEmail = TextEditingController();
  final TextEditingController signupPassword = TextEditingController();
  final TextEditingController signupConfirmPassword = TextEditingController();
  String userGender = '';
  double weight = 0;
  double tall = 140;
  int age = 0;

  login() async {
    emit(LoginLoading());
    try {
      final response = await api.post(EndPoint.login, data: {
        ApiKeys.email: loginEmail.text,
        ApiKeys.password: loginPassword.text
      });
      final userProfile = LoginResponseModel.fromJson(response);
      final token = userProfile.token;
      debugPrint(token);
      debugPrint(userProfile.user!.name);
      await CacheHelper.saveSecuredString(key: ApiKeys.token, value: token!);
      await CacheHelper.saveData(key: ApiKeys.id, value: userProfile.user!.id);
      await CacheHelper.saveData(
          key: ApiKeys.name, value: userProfile.user!.name);
      await CacheHelper.saveData(
          key: ApiKeys.weight, value: userProfile.user!.weight);
      await CacheHelper.saveData(
          key: ApiKeys.height, value: userProfile.user!.height);
      await CacheHelper.saveData(
          key: ApiKeys.age, value: userProfile.user!.age);
      await CacheHelper.saveData(
          key: ApiKeys.caloriesGoal, value: userProfile.user!.calorieGoal);
      debugPrint(CacheHelper.getData(key: userProfile.user!.name!));
      emit(LoginSuccess());
    } on ServerException catch (e) {
      emit(LoginFailure(e.errModel.errorMessage));
    }
  }

  signup() async {
    emit(SignUpLoading());
    try {
      await api.post(EndPoint.register, data: {
        ApiKeys.name: signupName.text,
        ApiKeys.email: signupEmail.text,
        ApiKeys.password: signupPassword.text,
        ApiKeys.height: tall.toInt().toString(),
        ApiKeys.age: age.toInt().toString(),
        ApiKeys.weight: weight.toInt().toString()
      });
      emit(SignUpSuccess());
    } on ServerException catch (e) {
      emit(SignUpFailure(e.errModel.errorMessage));
    }
  }

  void updateTall(double newTall) {
    tall = newTall;
    debugPrint(tall.toString());
    debugPrint(weight.toString());
    emit(AuthStateUpdated());
  }

  void updateWeight(double newWeight) {
    weight = newWeight;
    debugPrint(weight.toString());
    emit(AuthStateUpdated());
  }

  void selectGender(String gender) {
    userGender = gender;
    debugPrint(userGender);
    emit(AuthStateUpdated());
  }
}
