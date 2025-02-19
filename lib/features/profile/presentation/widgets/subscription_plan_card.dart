import 'package:flutter/material.dart';
import 'package:screenutil_module/main.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class PlanCard extends StatelessWidget {
  const PlanCard(
      {super.key,
      required this.image,
      required this.price,
      required this.plan,
      required this.color});
  final String image;
  final String price;
  final String plan;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.sp),
      child: Container(
        height: 140.h, // Adjust height as needed
        decoration: BoxDecoration(
          color: color, // Background color
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("$plan Plan",
                        style: CustomTextStyles.poppinsStyle18Bold),
                    const SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: price,
                              style: CustomTextStyles.poppins400Style20
                                  .copyWith(color: AppColors.dark)),
                          TextSpan(
                              text: "/month",
                              style: CustomTextStyles.poppins400Style12Grey),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "For $plan",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(image,width: 120.w,),
            ],
          ),
        ),
      ),
    );
  }
}
