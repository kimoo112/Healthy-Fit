// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../../core/utils/app_colors.dart';

class CircularSliderWidget extends StatelessWidget {
  const CircularSliderWidget({
    super.key,
    required this.initialValue,
    this.min,
    this.max,
    this.unit,
    this.onChange,
  });
  final double initialValue;
  final double? min;
  final double? max;
  final void Function(double)? onChange;
  final String? unit;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -100,
      right: 0,
      left: 0,
      child: SleekCircularSlider(
        initialValue: initialValue,
        min: min ?? 140, // Minimum weight
        max: max ?? 220, // Maximum weight
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
            progressBarColor: AppColors.primaryColor, // Progress bar color
            dotColor: AppColors.limeGreen, // Handle color
            hideShadow: true, // Disable shadow
          ),
          infoProperties: InfoProperties(
            mainLabelStyle: const TextStyle(),
            modifier: (double value) {
              final weightValue = value.toStringAsFixed(1);
              return "$weightValue $unit ";
            },
          ),
        ),
        onChange: onChange,
      ),
    );
  }
}
