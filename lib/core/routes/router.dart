import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_fit/core/routes/routes.dart';
import 'package:healthy_fit/features/auth/presentation/views/login_view.dart';
import 'package:healthy_fit/features/auth/presentation/views/signup_view.dart';
import 'package:healthy_fit/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:healthy_fit/features/splash/presentation/views/splash_view.dart';

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
      path: signup,
      builder: (BuildContext context, GoRouterState state) {
        return const SignupView();
      },
    ),
  ],
);
