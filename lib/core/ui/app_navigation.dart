import 'package:floating_navbar/floating_navbar.dart';
import 'package:floating_navbar/floating_navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/utils/app_colors.dart';
import 'package:healthy_fit/features/home/presentation/views/home_view.dart';
import 'package:healthy_fit/features/profile/presentation/views/profile_view.dart';
import 'package:iconly/iconly.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FloatingNavBar(
        borderRadius: 25.r,
        horizontalPadding: 10.0,
        hapticFeedback: true,
        resizeToAvoidBottomInset: true,
        color: AppColors.dark,
        selectedIconColor: AppColors.primaryColor,
        unselectedIconColor: Colors.white.withOpacity(0.6),
        items: [
          FloatingNavBarItem(
            iconData: IconlyBold.home,
            title: 'Home',
            page: const HomeView(),
          ),
          FloatingNavBarItem(
              iconData: IconlyBold.search,
              title: 'Search',
              page: const HomeView()),
          FloatingNavBarItem(
            iconData: IconlyBold.chart,
            title: 'Settings',
            page: const HomeView(),
          ),
          FloatingNavBarItem(
            iconData: IconlyBold.profile,
            title: 'Profile',
            page: const ProfileView(),
          ),
        ],
      ),
    );
  }
}
