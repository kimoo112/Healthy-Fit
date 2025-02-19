import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/routes/routes.dart';
import 'package:healthy_fit/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:healthy_fit/features/auth/presentation/widgets/circular_slider_widget.dart';

import '../../../../../core/routes/functions/navigation_functions.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/top_right_vectors.dart';
import '../../widgets/welcome_tall_widget.dart';

class TallView extends StatefulWidget {
  const TallView({super.key});

  @override
  State<TallView> createState() => _TallViewState();
}

class _TallViewState extends State<TallView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            double tall = context.read<AuthCubit>().tall;
            return Stack(
              children: [
                const TopRightVectors(),
                Column(
                  children: <Widget>[
                    50.verticalSpace,
                    const WelcomeTallWidget(),
                    50.verticalSpace,
                    Container(
                        alignment: Alignment.center,
                        width: 120.w,
                        height: tall,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.limeGreen.withOpacity(.3)),
                        child: Text(
                          "${tall.toInt()} Cm",
                          style: CustomTextStyles.poppins400Style20,
                        )),
                  ],
                ),
                CircularSliderWidget(
                  initialValue: tall,
                  unit: "Cm",
                  onChange: context.read<AuthCubit>().updateTall,
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: CustomButton(
                      onPressed: tall == 140
                          ? () {}
                          : () {
                              customNavigate(context, goalSelectionView);
                            },
                      text: 'Next',
                      borderRadius: 12,
                      color: tall == 140
                          ? AppColors.primaryColor.withOpacity(.6)
                          : AppColors.primaryColor,
                      textColor: AppColors.white,
                    ))
              ],
            );
          },
        ),
      ),
    );
  }
}
