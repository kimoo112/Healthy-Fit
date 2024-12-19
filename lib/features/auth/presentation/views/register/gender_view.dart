import 'package:flutter/material.dart';
import 'package:healthy_fit/core/routes/functions/navigation_functions.dart';
import 'package:healthy_fit/core/routes/routes.dart';
import 'package:healthy_fit/core/widgets/custom_button.dart';
import 'package:screenutil_module/util/config/global_imports.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/top_right_vectors.dart';
import '../../widgets/gender_container.dart';

class GenderView extends StatefulWidget {
  const GenderView({super.key});

  @override
  State<GenderView> createState() => _GenderViewState();
}

class _GenderViewState extends State<GenderView> {
  String selectedGender = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const TopRightVectors(),
          Positioned(
              right: 0,
              child: CustomButton(
                text: 'skip',
                width: 90.w,
                onPressed: () {
                  customNavigate(context, ageView);
                },
                fontSize: 12.sp,
                color: AppColors.softGrey,
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                90.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'What is your ',
                      style: CustomTextStyles.poppins500Style18,
                    ),
                    Text(
                      'gender?',
                      style: CustomTextStyles.poppins500Style18
                          .copyWith(color: AppColors.primaryColor),
                    )
                  ],
                ),
                11.verticalSpace,
                Text(
                  'We will use this data to give you a better diet type for you',
                  style: CustomTextStyles.poppins400Style14
                      .copyWith(color: AppColors.grey),
                  textAlign: TextAlign.center,
                ),
                120.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedGender = "Male";
                        });
                      },
                      child: GenderContainer(
                        genderImage: Assets.imagesMale,
                        genderType: "Male",
                        isSelected: selectedGender == "Male",
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedGender = "Female";
                        });
                      },
                      child: GenderContainer(
                        isSelected: selectedGender == "Female",
                        genderImage: Assets.imagesFemale,
                        genderType: "Female",
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                CustomButton(
                  onPressed: selectedGender == ""
                      ? () {}
                      : () {
                          customNavigate(context, ageView);
                        },
                  text: 'Next',
                  borderRadius: 12,
                  color: selectedGender == ""
                      ? AppColors.primaryColor.withOpacity(.6)
                      : AppColors.primaryColor,
                  textColor: AppColors.white,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
