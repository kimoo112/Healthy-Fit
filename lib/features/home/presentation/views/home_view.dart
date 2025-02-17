import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/api/end_points.dart';
import 'package:healthy_fit/core/cache/cache_helper.dart';
import 'package:healthy_fit/core/routes/functions/navigation_functions.dart';
import 'package:healthy_fit/core/utils/app_colors.dart';
import 'package:healthy_fit/core/utils/app_text_styles.dart';
import 'package:healthy_fit/features/home/cubit/home_cubit.dart';
import 'package:healthy_fit/features/home/presentation/widgets/food_list_view.dart';

import '../../../../core/routes/routes.dart';
import '../widgets/calories_container.dart';
import '../widgets/carbs_fats_container.dart';
import '../widgets/user_info.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchCaloriesGoals();
    context.read<HomeCubit>().fetchFood(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0.sp),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final cachedCalories =
                CacheHelper.getData(key: ApiKeys.caloriesGoal) as int?;
            int? calorieGoal = cachedCalories ??
                (state is GetCaloriesGoalSuccess ? state.calorieGoal : null);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const UserInfo(),
                40.verticalSpace,
                _buildHomeTitle(),
                22.verticalSpace,
                CaloriesContainer(
                    calorieGoal: calorieGoal,
                    userId: CacheHelper.getData(key: ApiKeys.id)),
                8.verticalSpace,
                const CarbsAndFatsContainer(),
                8.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Today’s Meal'),
                    TextButton(
                      onPressed: () {
                        customNavigate(context, addMealsView);
                      },
                      child: Text(
                        "Add Meal",
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
                16.verticalSpace,
                const Expanded(child: FoodListViewWidget()),
              ],
            );
          },
        ),
      ),
    );
  }

  Column _buildHomeTitle() {
    return Column(
      children: [
        Text(
          'Good Morning ☀',
          style: CustomTextStyles.poppins400Style24,
        ),
        5.verticalSpace,
        Text(
          'Hope you have a good day ',
          style: CustomTextStyles.poppins400Style14
              .copyWith(color: AppColors.grey),
        ),
      ],
    );
  }
}
