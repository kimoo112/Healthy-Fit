import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_fit/core/routes/routes.dart';
import 'package:healthy_fit/core/ui/app_navigation.dart';
import 'package:healthy_fit/features/auth/presentation/views/login/login_view.dart';
import 'package:healthy_fit/features/auth/presentation/views/register/age_view.dart';
import 'package:healthy_fit/features/auth/presentation/views/register/signup_view.dart';
import 'package:healthy_fit/features/auth/presentation/views/register/tall_view.dart';
import 'package:healthy_fit/features/auth/presentation/views/register/weight_view.dart';
import 'package:healthy_fit/features/home/presentation/views/add_meal_view.dart';
import 'package:healthy_fit/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:healthy_fit/features/profile/presentation/views/card_view.dart';
import 'package:healthy_fit/features/profile/presentation/views/general_settings_view.dart';
import 'package:healthy_fit/features/profile/presentation/views/profile_view.dart';
import 'package:healthy_fit/features/profile/presentation/views/subscription_view.dart';
import 'package:healthy_fit/features/splash/presentation/views/splash_view.dart';

import '../../features/auth/presentation/views/register/gender_view.dart';
import '../../features/auth/presentation/views/register/goal_selection_view.dart';
import '../../features/home/data/food_model/food_model/food_model.dart';
import '../../features/home/presentation/views/food_details_view.dart';
import '../../features/notes/presentation/cubit/notes_cubit.dart';

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
    GoRoute(
      path: goalSelectionView,
      builder: (BuildContext context, GoRouterState state) {
        return const GoalSelectionView();
      },
    ),
    GoRoute(
      path: appNavigation,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => NotesCubit()..fetchNotes(),
          child: const AppNavigation(),
        );
      },
    ),
    GoRoute(
      path: addMealsView,
      builder: (BuildContext context, GoRouterState state) {
        return const AddMealView();
      },
    ),
    GoRoute(
      path: foodDetails,
      builder: (context, state) {
        final foodItem = state.extra as FoodModel;
        return FoodDetailsScreen(foodItem: foodItem);
      },
    ),
    GoRoute(
      path: profileView,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileView();
      },
    ),
    GoRoute(
      path: subscriptionView,
      builder: (BuildContext context, GoRouterState state) {
        return const SubscriptionView();
      },
    ),
    GoRoute(
      path: cardView,
      builder: (BuildContext context, GoRouterState state) {
        final Map<String, String> args =
            state.extra as Map<String, String>? ?? {};
        return CardView(
          selectedPlan: args['selectedPlan'] ?? '',
          planPrice: args['planPrice'] ?? '',
        );
      },
    ),
    GoRoute(
      path: generalSettingsView,
      builder: (BuildContext context, GoRouterState state) {
        return const GeneralSettingsView();
      },
    ),
  ],
);
