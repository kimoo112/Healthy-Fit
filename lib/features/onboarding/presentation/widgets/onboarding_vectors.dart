
import 'package:flutter/material.dart';

import '../../../../core/utils/app_assets.dart';

class OnboardingVectors extends StatelessWidget {
  const OnboardingVectors({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Image.asset(Assets.imagesOnboardingVector),
    );
  }
}
