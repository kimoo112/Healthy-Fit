import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy_fit/core/routes/functions/navigation_functions.dart';
import 'package:healthy_fit/core/routes/routes.dart';
import 'package:healthy_fit/core/utils/app_colors.dart';
import 'package:healthy_fit/core/widgets/custom_button.dart';
import 'package:healthy_fit/core/widgets/custom_text_form_field.dart';

import '../../../../../core/utils/app_text_styles.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle,
                    color: AppColors.primaryColor, size: 60),
                SizedBox(height: 15.h),
                Text(
                  "Success!",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "A reset code has been sent to your email.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.sp, color: Colors.black54),
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  text: "OK",
                  onPressed: () {
                    Navigator.pop(context);
                    customReplacementNavigate(context, login);
                  },
                  fontSize: 14.sp,
                  textColor: Colors.white,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onSendPressed() {
    if (_formKey.currentState!.validate()) {
      _showSuccessDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 50.sp),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'FORGET PASSWORD 👀',
                style: CustomTextStyles.poppinsStyle20Bold,
              ),
              10.verticalSpace,
              Text(
                "Enter your email to reset your password",
                style: CustomTextStyles.poppins400Style12Grey,
              ),
              50.verticalSpace,
              CustomTextFormField(
                controller: _emailController,
                hintText: "Enter your email",
                isHavePrefix: false,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              50.verticalSpace,
              CustomButton(
                text: "Send",
                fontSize: 12.sp,
                textColor: AppColors.white,
                onPressed: _onSendPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
