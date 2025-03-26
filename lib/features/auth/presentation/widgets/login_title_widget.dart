

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_text_styles.dart';

class LoginTitleWidget extends StatelessWidget {
  const LoginTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome Back 👋',
          style: CustomTextStyles.poppinsStyle20Bold,
        ),
        10.verticalSpace,
        Text(
          'Hi there, you’ve been missed',
          style: CustomTextStyles.poppins400Style12Grey,
        ),
        40.verticalSpace,
      ],
    );
  }
}
