import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class CustomSignupForm extends StatelessWidget {
  const CustomSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Create Your Account',
              style: CustomTextStyles.poppins400Style20Bold,
            ),
            10.verticalSpace,
            Text(
              'Sign up to access all features and start achieving your fitness goals.',
              style: CustomTextStyles.poppins400Style12Grey,
              textAlign: TextAlign.center,
            ),
            40.verticalSpace,
            CustomTextFormField(
              isHavePrefix: false,
              hintText: 'Name',
              suffixIcon: Icon(
                Icons.person,
                color: AppColors.primaryColor,
              ),
            ),
            30.verticalSpace,
            CustomTextFormField(
              isHavePrefix: false,
              hintText: 'Email',
              suffixIcon: Icon(
                Icons.email,
                color: AppColors.primaryColor,
              ),
            ),
            30.verticalSpace,
            CustomTextFormField(
              isHavePrefix: false,
              hintText: 'Password',
              suffixIcon: Icon(
                Icons.lock,
                color: AppColors.primaryColor,
              ),
            ),
            30.verticalSpace,
            CustomTextFormField(
              isHavePrefix: false,
              hintText: 'Confirm Password',
              suffixIcon: Icon(
                Icons.lock,
                color: AppColors.primaryColor,
              ),
            ),
            50.verticalSpace,
            CustomButton(
              marginSize: 0,
              text: 'SIGNUP',
              textColor: AppColors.white,
              borderRadius: 12,
            ),
            
          ],
        ),
      ),
    );
  }
}
