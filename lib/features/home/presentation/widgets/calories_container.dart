import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/utils/app_colors.dart';
import 'package:healthy_fit/core/utils/app_text_styles.dart';
import 'package:hive_flutter/hive_flutter.dart'; // ✅ Import Hive
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CaloriesContainer extends StatelessWidget {
  const CaloriesContainer({
    super.key,
    required this.calorieGoal,
    required this.userId, // ✅ Add userId parameter
  });

  final int? calorieGoal;
  final String userId; // ✅ Store userId

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('nutritionBox'); // ✅ Access Hive Box

    return ValueListenableBuilder(
      valueListenable: box.listenable(), // ✅ Listen for changes
      builder: (context, Box<dynamic> box, _) {
        // ✅ Use user-specific key
        final currentCalories = box.get('myCalories_$userId', defaultValue: 0);
        debugPrint("Current Calories: $currentCalories"); // ✅ Debug print

        double progressPercentage =
            (currentCalories / (calorieGoal ?? 2000)) * 100;

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
                    return " $currentCalories Kcal"; // ✅ Updated dynamically
                  },
                  bottomLabelText: "of $calorieGoal Kcal",
                ),
                customColors: CustomSliderColors(
                  trackColor: progressColor.withOpacity(.5),
                  dotColor: progressColor,
                  progressBarColor: progressColor,
                  shadowMaxOpacity: .0010,
                  shadowColor: AppColors.limeGreen.withOpacity(.00001),
                ),
                customWidths:
                    CustomSliderWidths(progressBarWidth: 20, trackWidth: 20),
              ),
              min: 0,
              max: calorieGoal?.toDouble() ?? 2000,
              initialValue: currentCalories.toDouble(), // ✅ Updated dynamically
            ),
          ),
        );
      },
    );
  }
}
