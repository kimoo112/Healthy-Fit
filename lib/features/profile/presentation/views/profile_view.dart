import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/api/end_points.dart';
import 'package:healthy_fit/core/cache/cache_helper.dart';
import 'package:healthy_fit/core/routes/routes.dart';
import 'package:healthy_fit/core/utils/app_assets.dart';
import 'package:healthy_fit/core/utils/app_colors.dart';
import 'package:healthy_fit/core/utils/app_text_styles.dart';
import 'package:iconly/iconly.dart';

import '../../../../core/routes/functions/navigation_functions.dart';
import '../../../../core/widgets/top_right_vectors.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  void _loadProfileData() {
    setState(() {}); 
    CacheHelper.getData(key: 'profile_image');
    CacheHelper.getData(key: ApiKeys.name);
    CacheHelper.getData(key: ApiKeys.newWeight);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadProfileData(); // Reload data when dependencies change
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () async {
                  await CacheHelper.removeSecuredString(key: ApiKeys.token);
                  await CacheHelper.clearData();

                  if (context.mounted) {
                    customNavigate(context, login);
                  }
                },
                icon: const Icon(IconlyBold.logout),
              ),
            ],
            leading: const SizedBox(),
          ),
          body: Stack(
            children: [
              const TopRightVectors(),
              Column(
                children: <Widget>[
                  70.verticalSpace,
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: AppColors.primaryColor,
                    backgroundImage: CacheHelper.getData(
                                key: 'profile_image') !=
                            null
                        ? FileImage(File(CacheHelper.getData(
                            key: 'profile_image')!)) // Convert String to File
                        : null,
                    child: CacheHelper.getData(key: 'profile_image') == null
                        ? Icon(IconlyBold.profile,
                            size: 50, color: AppColors.white)
                        : null,
                  ),
                  5.verticalSpace,
                  Text(CacheHelper.getData(key: ApiKeys.name)),
                  5.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${CacheHelper.getData(key: ApiKeys.age)}",
                        style: CustomTextStyles.poppins400Style14,
                      ),
                      Text(
                        " yo - ",
                        style: CustomTextStyles.poppins400Style12Grey,
                      ),
                      Text(
                        "${CacheHelper.getData(key: ApiKeys.height)}",
                        style: CustomTextStyles.poppins400Style14,
                      ),
                      Text(
                        " cm - ",
                        style: CustomTextStyles.poppins400Style12Grey,
                      ),
                      Text(
                        CacheHelper.getData(key: ApiKeys.newWeight)
                                ?.toString() ??
                            CacheHelper.getData(key: ApiKeys.weight).toString(),
                        style: CustomTextStyles.poppins400Style14,
                      ),
                      Text(
                        " kg ",
                        style: CustomTextStyles.poppins400Style12Grey,
                      ),
                    ],
                  ),
                  24.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          customNavigate(context, subscriptionView);
                        },
                        child: _buildIconButton(
                            Assets.imagesSubscription, 'Subscription'),
                      ),
                      GestureDetector(
                          onTap: () {
                            customNavigate(
                              context,
                              userProfile,
                              onReturn: () => setState(() {}),
                            );
                          },
                          child: _buildIconButton(
                              Assets.imagesProfile, 'Profile')),
                    ],
                  ),
                  24.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            customNavigate(context, helpView);
                          },
                          child: _buildIconButton(Assets.imagesHelp, 'Help')),
                      GestureDetector(
                          onTap: () {
                            customNavigate(context, generalSettingsView);
                          },
                          child: _buildIconButton(
                              Assets.imagesGeneral, 'General')),
                    ],
                  ),
                  24.verticalSpace,
                ],
              ),
            ],
          )),
    );
  }

  Widget _buildIconButton(String image, String label) {
    return Container(
      width: 160.w,
      height: 120.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                blurRadius: 2,
                spreadRadius: 6,
                color: AppColors.softGrey.withOpacity(.6))
          ],
          color: AppColors.primaryColor.withOpacity(.2)),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image),
          16.verticalSpace,
          Text(label, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
