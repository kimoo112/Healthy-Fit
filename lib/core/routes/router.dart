import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_fit/core/routes/routes.dart';
import 'package:healthy_fit/features/auth/presentation/views/login/login_view.dart';
import 'package:healthy_fit/features/auth/presentation/views/register/age_view.dart';
import 'package:healthy_fit/features/auth/presentation/views/register/signup_view.dart';
import 'package:healthy_fit/features/auth/presentation/views/register/tall_view.dart';
import 'package:healthy_fit/features/auth/presentation/views/register/weight_view.dart';
import 'package:healthy_fit/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:healthy_fit/features/splash/presentation/views/splash_view.dart';

import '../../features/auth/presentation/views/register/gender_view.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashView();
      },
    ),
    GoRoute(
      path: onboarding,
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingPage();
      },
    ),
    GoRoute(
      path: login,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginView();
      },
    ),
    GoRoute(
      path: genderView,
      builder: (BuildContext context, GoRouterState state) {
        return const GenderView();
      },
    ),
    GoRoute(
      path: ageView,
      builder: (BuildContext context, GoRouterState state) {
        return const AgeView();
      },
    ),
    GoRoute(
      path: weightView,
      builder: (BuildContext context, GoRouterState state) {
        return const WeightView();
      },
    ),
    GoRoute(
      path: tallView,
      builder: (BuildContext context, GoRouterState state) {
        return const TallView();
      },
    ),
    GoRoute(
      path: signup,
      builder: (BuildContext context, GoRouterState state) {
        return const SignupView();
      },
    ),
  ],
);
