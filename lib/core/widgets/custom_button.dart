import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.color,
    required this.text,
    this.onPressed,
    this.marginSize,
    this.width,
    this.fontSize,
    this.textColor,
    this.borderRadius,
  });

  final Color? color;
  final String text;
  final Color? textColor;
  final VoidCallback? onPressed;
  final double? marginSize;
  final double? width;
  final double? fontSize;
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(borderRadius ?? 55),
      child: Container(
        margin: EdgeInsets.all(marginSize ?? 8),
        width: width ?? double.infinity,
        height: 56,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 7,
                spreadRadius: 2,
                color: AppColors.grey.withOpacity(.2))
          ],
          color: color ?? AppColors.dark,
          borderRadius: BorderRadius.circular(borderRadius ?? 55),
        ),
        alignment: Alignment.center,
        child: Text(text,
            style: CustomTextStyles.poppins400Style16
                .copyWith(color: textColor, fontSize: fontSize ?? 20.sp)),
      ),
    );
  }
}
