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

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text('Account'),
            actions: [
              IconButton(
                onPressed: () async {
                  await CacheHelper.removeSecuredString(key: ApiKeys.token);
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
                    minRadius: 55.r,
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
                        "${CacheHelper.getData(key: ApiKeys.weight)}",
                        style: CustomTextStyles.poppins400Style14,
                      ),
                      Text(
                        " kg ",
                        style: CustomTextStyles.poppins400Style12Grey,
                      ),
                    ],
                  ),
                  // Reminder Section

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
                      _buildIconButton(Assets.imagesProfile, 'Profile'),
                    ],
                  ),
                  24.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildIconButton(Assets.imagesHelp, 'Help'),
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
