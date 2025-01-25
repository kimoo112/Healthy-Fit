import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/api/end_points.dart';
import 'package:healthy_fit/core/cache/cache_helper.dart';
import 'package:healthy_fit/core/utils/app_text_styles.dart';
import 'package:iconly/iconly.dart';

import '../../../../core/widgets/top_right_vectors.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Account'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(IconlyBold.logout),
          ),
        ],
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
              )
            ],
          ),
        ],
      ),
    );
  }
}
