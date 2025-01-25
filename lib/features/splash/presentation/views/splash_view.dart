import 'package:flutter/material.dart';
import 'package:healthy_fit/core/api/end_points.dart';
import 'package:healthy_fit/core/cache/cache_helper.dart';
import 'package:healthy_fit/core/routes/functions/navigation_functions.dart';
import 'package:healthy_fit/core/routes/routes.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _checkTokenAndNavigate();
  }

  void _checkTokenAndNavigate() async {
    final token = await CacheHelper.getSecuredString(key: ApiKeys.token);
    debugPrint('Token: $token');
    if (!mounted) return;
    delayedNavigate(
      context,
      token != '' ? appNavigation : onboarding,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.limeGreen,
                  AppColors.primaryColor,
                  AppColors.primaryColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Image.asset(Assets.imagesLogo),
            ),
          ),
          Positioned(bottom: 0, child: Image.asset(Assets.imagesSplashVectors))
        ],
      ),
    );
  }
}
