import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/api/end_points.dart';
import 'package:healthy_fit/core/cache/cache_helper.dart';
import 'package:healthy_fit/core/utils/app_text_styles.dart';

import '../../../../core/utils/app_assets.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          Assets.imagesGreenSlogan,
          width: 44.w,
        ),
        6.horizontalSpace,
        Column(
          children: [
            Text(
              'Welcome ',
              style: CustomTextStyles.poppins400Style12Grey,
            ),
            3.verticalSpace,
            Text(
              CacheHelper.getData(key: ApiKeys.name),
              style: CustomTextStyles.poppins400Style20,
            ),
          ],
        ),
      ],
    );
  }
}
