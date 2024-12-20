import 'package:flutter/material.dart';

import '../utils/app_assets.dart';

class TopRightVectors extends StatelessWidget {
  const TopRightVectors({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 0, top: 0, child: Image.asset(Assets.imagesVectors));
  }
}
