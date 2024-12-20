import 'package:flutter/material.dart';
import 'package:screenutil_module/util/config/global_imports.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class GenderWelcomeWidget extends StatelessWidget {
  const GenderWelcomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}
