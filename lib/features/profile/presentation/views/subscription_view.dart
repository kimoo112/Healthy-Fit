import 'package:flutter/material.dart';
import 'package:healthy_fit/core/utils/app_assets.dart';
import 'package:healthy_fit/core/widgets/custom_button.dart';
import 'package:healthy_fit/features/profile/presentation/widgets/subscription_plan_card.dart';
import 'package:screenutil_module/main.dart';

import '../../../../core/routes/functions/navigation_functions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class SubscriptionView extends StatefulWidget {
  const SubscriptionView({super.key});

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  String? selectedPlan;
  String? planPrice; // Store the selected plan's price

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(child: Image.asset(Assets.imagesTopLeftVectors)),
          Padding(
            padding: EdgeInsets.only(top: 40.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.imagesSubscription,
                  width: 50,
                ),
                Text(
                  'Upgrade plan\n to get the best of HealthyFit',
                  style: CustomTextStyles.poppinsStyle18Bold,
                  textAlign: TextAlign.center,
                ),
                10.verticalSpace,
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '99%',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                      const TextSpan(
                        text:
                            ' of LifeFit users recommended you to upgrade plan!',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                50.verticalSpace,

                // Beginner Plan
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPlan = "Beginner";
                      planPrice = "\$39";
                    });
                  },
                  child: PlanCard(
                    image: Assets.imagesBeginner,
                    price: '\$39',
                    plan: "Beginner",
                    color: selectedPlan == "Beginner"
                        ? AppColors.limeGreen.withOpacity(.4) // Highlighted color
                        : AppColors.red.withOpacity(.2),
                  ),
                ),

                20.verticalSpace,

                // Pro Plan
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPlan = "Pro";
                      planPrice = "\$199";
                    });
                  },
                  child: PlanCard(
                    image: Assets.imagesProUser,
                    price: '\$199',
                    plan: "Pro",
                    color: selectedPlan == "Pro"
                        ? AppColors.limeGreen.withOpacity(.4) // Highlighted color
                        : AppColors.grey.withOpacity(.2),
                  ),
                ),
              ],
            ),
          ),

          // Select Plan Button
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: CustomButton(
              onPressed: selectedPlan != null && planPrice != null
                  ? () {
                      customNavigate(
                        context, 
                        cardView,
                        extra: {
                          'selectedPlan': selectedPlan!,
                          'planPrice': planPrice!,
                        },
                      );
                    }
                  : null, 
              text: 'Select Plan',
              textColor: AppColors.white,
              fontSize: 14.sp,
              color: selectedPlan == null
                  ? AppColors.dark.withOpacity(.6) 
                  : AppColors.dark,
            ),
          ),
        ],
      ),
    );
  }
}