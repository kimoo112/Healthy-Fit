import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/widgets/custom_button.dart';
import 'package:healthy_fit/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:healthy_fit/features/auth/presentation/widgets/circular_slider_widget.dart';

import '../../../../../core/routes/functions/navigation_functions.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/top_right_vectors.dart';

class WeightView extends StatefulWidget {
  const WeightView({super.key});

  @override
  State<WeightView> createState() => _WeightViewState();
}

class _WeightViewState extends State<WeightView> {
  double weight = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            double weight = context.read<AuthCubit>().weight;
            return Stack(
              children: [
                const TopRightVectors(),
                Column(
                  children: <Widget>[
                    50.verticalSpace,
                    const WelcomeWeightWidget(),
                    50.verticalSpace,
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 150.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.limeGreen.withOpacity(.3)),
                        child: Text(
                          "${weight.toInt()} Kg",

                          style: CustomTextStyles.poppins400Style20,
                        )),
                  ],
                ),
                CircularSliderWidget(
                  initialValue: weight,
                  unit:"Kg",
                  min: 0,
                  max: 150,
                  onChange: context.read<AuthCubit>().updateWeight,
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: CustomButton(
                      onPressed: weight == 0
                          ? () {}
                          : () {
                              customNavigate(context, tallView);
                            },
                      text: 'Next',
                      borderRadius: 12,
                      color: weight == 0
                          ? AppColors.primaryColor.withOpacity(.6)
                          : AppColors.primaryColor,
                      textColor: AppColors.white,
                    )),
              ],
            );
          },
        ),
      ),
    );
  }
}

class WelcomeWeightWidget extends StatelessWidget {
  const WelcomeWeightWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your ',
              style: CustomTextStyles.poppins500Style18,
            ),
            Text(
              'current weight',
              style: CustomTextStyles.poppins500Style18
                  .copyWith(color: AppColors.primaryColor),
            )
          ],
        ),
        11.verticalSpace,
        Text(
          'We will use this data to give you a better diet type for you',
          style: CustomTextStyles.poppins400Style12
              .copyWith(color: AppColors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
