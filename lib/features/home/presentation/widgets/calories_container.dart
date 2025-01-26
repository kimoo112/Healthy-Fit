import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/utils/app_colors.dart';
import 'package:healthy_fit/core/utils/app_text_styles.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../../core/cache/cache_helper.dart';

class CaloriesContainer extends StatelessWidget {
  const CaloriesContainer({
    super.key,
    required this.calorieGoal,
    this.myCalories,
  });

  final int? calorieGoal;
  final int? myCalories;

  @override
  Widget build(BuildContext context) {
    double progressPercentage = (myCalories! / (calorieGoal ?? 2000)) * 100;

    Color progressColor;
    if (progressPercentage < 40) {
      progressColor = AppColors.red;
    } else if (progressPercentage < 80) {
      progressColor = AppColors.yellow;
    } else {
      progressColor = AppColors.primaryColor;
    }
    return Container(
      width: double.infinity,
      height: 255.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.limeGreen.withOpacity(.3),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 22.0.sp),
        child: SleekCircularSlider(
          appearance: CircularSliderAppearance(
              infoProperties: InfoProperties(
                  topLabelStyle: CustomTextStyles.poppins400Style14,
                  bottomLabelStyle: CustomTextStyles.poppins400Style12Grey,
                  topLabelText: 'Calories',
                  modifier: (percentage) {
                    return " ${CacheHelper.getData(key: 'myCalories') ?? myCalories} Kcal";
                  },
                  bottomLabelText: "of $calorieGoal Kcal"),
              customColors: CustomSliderColors(
                  trackColor: progressColor.withOpacity(.5),
                  dotColor: progressColor,
                  progressBarColor: progressColor,
                  shadowMaxOpacity: .0010,
                  shadowColor: AppColors.limeGreen.withOpacity(.00001)),
              customWidths:
                  CustomSliderWidths(progressBarWidth: 20, trackWidth: 20)),
          min: 0,
          max: calorieGoal?.toDouble() ?? 2000,
          initialValue: myCalories!.toDouble(),
        ),
      ),
    );
  }
}
