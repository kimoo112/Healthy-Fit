
import 'package:flutter/material.dart';
import 'package:screenutil_module/main.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class CustomLoginForm extends StatelessWidget {
  const CustomLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Welcome Back 👋',
            style: CustomTextStyles.poppins400Style20Bold,
          ),
          10.verticalSpace,
          Text(
            'Hi there, you’ve been missed',
            style: CustomTextStyles.poppins400Style12Grey,
          ),
          40.verticalSpace,
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
            hintText: 'password',
            suffixIcon: Icon(
              Icons.lock,
              color: AppColors.primaryColor,
            ),
          ),
          50.verticalSpace,
          CustomButton(
            marginSize: 0,
            text: 'Login',
            textColor: AppColors.white,
            borderRadius: 12,
          )
        ],
      ),
    );
  }
}
