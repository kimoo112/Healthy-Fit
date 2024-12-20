import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_fit/core/routes/functions/navigation_functions.dart';
import 'package:healthy_fit/core/routes/routes.dart';
import 'package:healthy_fit/core/widgets/custom_button.dart';
import 'package:healthy_fit/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:screenutil_module/util/config/global_imports.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/top_right_vectors.dart';
import '../../widgets/gender_container.dart';
import '../../widgets/gender_welcome_widget.dart';

class GenderView extends StatelessWidget {
  const GenderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const TopRightVectors(),
          Positioned(
              right: 0,
              child: CustomButton(
                text: 'skip',
                width: 90.w,
                onPressed: () {
                  customNavigate(context, ageView);
                },
                textColor: AppColors.primaryColor,
                fontSize: 12.sp,
                color: AppColors.softGrey,
              )),
          Positioned(
              left: 0,
              child: CustomButton(
                text: '<',
                textColor: AppColors.primaryColor,
                width: 90.w,
                onPressed: () {
                  customReplacementNavigate(context, login);
                },
                fontSize: 25.sp,
                color: AppColors.softGrey,
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                90.verticalSpace,
                const GenderWelcomeWidget(),
                120.verticalSpace,
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    String selectedGender =
                        context.read<AuthCubit>().userGender;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<AuthCubit>().selectGender("Male");
                          },
                          child: GenderContainer(
                            genderImage: Assets.imagesMale,
                            genderType: "Male",
                            isSelected: selectedGender == "Male",
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<AuthCubit>().selectGender("Female");
                          },
                          child: GenderContainer(
                            isSelected: selectedGender == "Female",
                            genderImage: Assets.imagesFemale,
                            genderType: "Female",
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const Spacer(),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    String selectedGender =
                        context.read<AuthCubit>().userGender;
                    return CustomButton(
                      onPressed: selectedGender == ""
                          ? () {}
                          : () {
                              customNavigate(context, ageView);
                            },
                      text: 'Next',
                      borderRadius: 12,
                      color: selectedGender == ""
                          ? AppColors.primaryColor.withOpacity(.6)
                          : AppColors.primaryColor,
                      textColor: AppColors.white,
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
