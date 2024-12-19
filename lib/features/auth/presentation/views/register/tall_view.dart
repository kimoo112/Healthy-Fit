import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/routes/routes.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../../../core/routes/functions/navigation_functions.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/top_right_vectors.dart';

class TallView extends StatefulWidget {
  const TallView({super.key});

  @override
  State<TallView> createState() => _TallViewState();
}

class _TallViewState extends State<TallView> {
  double tall = 140;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            const TopRightVectors(),
            Column(
              children: <Widget>[
                50.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'How ',
                      style: CustomTextStyles.poppins500Style18,
                    ),
                    Text(
                      'Tall',
                      style: CustomTextStyles.poppins500Style18
                          .copyWith(color: AppColors.primaryColor),
                    ),
                    Text(
                      ' are you ',
                      style: CustomTextStyles.poppins500Style18,
                    ),
                  ],
                ),
                11.verticalSpace,
                Text(
                  'We will use this data to give you a better diet type for you',
                  style: CustomTextStyles.poppins400Style12
                      .copyWith(color: AppColors.grey),
                  textAlign: TextAlign.center,
                ),
                50.verticalSpace,
                Container(
                    alignment: Alignment.center,
                    width: 100.w,
                    height: 150.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.limeGreen.withOpacity(.3)),
                    child: Text(
                      "${tall.toInt()} Cm",
                      style: CustomTextStyles.poppins400Style20,
                    )),
              ],
            ),
            Positioned(
              bottom: -100,
              right: 0,
              left: 0,
              child: SleekCircularSlider(
                initialValue: tall,
                min: 140, // Minimum weight
                max: 220, // Maximum weight
                appearance: CircularSliderAppearance(
                  size: 400, // Diameter of the slider
                  startAngle:
                      180, // Where the slider starts (270° makes it start from the left)
                  angleRange: 180, // Full circle range
                  customWidths: CustomSliderWidths(
                    trackWidth: 10, // Background track width
                    progressBarWidth: 15, // Progress bar width
                    handlerSize: 10, // Handle size
                  ),
                  customColors: CustomSliderColors(
                    trackColor: Colors.grey[300]!, // Background track color
                    progressBarColor:
                        AppColors.primaryColor, // Progress bar color
                    dotColor: AppColors.limeGreen, // Handle color
                    hideShadow: true, // Disable shadow
                  ),
                  infoProperties: InfoProperties(
                    mainLabelStyle: const TextStyle(),
                    modifier: (double value) {
                      final weightValue = value.toStringAsFixed(1);
                      return "$weightValue cm";
                    },
                  ),
                ),
                onChange: (double value) {
                  setState(() {
                    tall = value;
                  });
                },
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: CustomButton(
                  onPressed: tall == 140
                      ? () {}
                      : () {
                          customNavigate(context, signup);
                        },
                  text: 'Next',
                  borderRadius: 12,
                  color: tall == 0
                      ? AppColors.primaryColor.withOpacity(.6)
                      : AppColors.primaryColor,
                  textColor: AppColors.white,
                ))
          ],
        ),
      ),
    );
  }
}
