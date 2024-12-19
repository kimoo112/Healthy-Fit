import 'package:flutter/material.dart';
import 'package:screenutil_module/main.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class GenderContainer extends StatelessWidget {
  const GenderContainer({
    super.key,
    required this.genderImage,
    required this.genderType,
    required this.isSelected,
  });
  final String genderImage;
  final String genderType;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      height: 178.h,
      decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.softGrey,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                spreadRadius: 2,
                color: AppColors.grey.withOpacity(.1)),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(genderImage),
          11.verticalSpace,
          Text(
            genderType,
            style: CustomTextStyles.poppins500Style18.copyWith(
                color:
                    isSelected ? AppColors.softGrey : AppColors.primaryColor),
          )
        ],
      ),
    );
  }
}
