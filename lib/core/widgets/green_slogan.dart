import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_assets.dart';

class GreenSlogan extends StatelessWidget {
  const GreenSlogan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 20.h, left: 10.w, child: Image.asset(Assets.imagesGreenSlogan));
  }
}
