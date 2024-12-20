import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class WelcomeWeightWidget extends StatelessWidget {
  const WelcomeWeightWidget({
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
              'Your ',
              style: CustomTextStyles.poppins500Style18,
            ),
            Text(
              'current weight',
              style: CustomTextStyles.poppins500Style18
                  .copyWith(color: AppColors.primaryColor),
            )
          ],
        ),
        11.verticalSpace,
        Text(
          'We will use this data to give you a better diet type for you',
          style: CustomTextStyles.poppins400Style12
              .copyWith(color: AppColors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
