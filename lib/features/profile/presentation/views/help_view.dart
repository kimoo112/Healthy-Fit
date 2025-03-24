import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/utils/app_colors.dart';
import 'package:healthy_fit/core/widgets/custom_button.dart';

class HelpView extends StatelessWidget {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to Healthy Fit!",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              "Healthy Fit is your ultimate companion for leading a healthier life! Track your daily calories, monitor your fitness progress with charts, set goals, and take notes to stay on top of your health journey.",
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 20.h),
            _buildFeatureItem(Icons.local_fire_department, "Calorie Tracking",
                "Monitor your daily calorie intake and stay within your goals."),
            _buildFeatureItem(Icons.stacked_bar_chart, "Progress Charts",
                "Visualize your health trends over time."),
            _buildFeatureItem(Icons.note, "Notes & Reminders",
                "Keep track of your meals, workouts, and important health notes."),
            _buildFeatureItem(Icons.fitness_center, "Personalized Goals",
                "Set fitness and health targets that suit your lifestyle."),
            const Spacer(),
            CustomButton(
              onPressed: () => Navigator.pop(context),
              text: "Back",
              fontSize: 14.sp,
              textColor: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 28.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  description,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
