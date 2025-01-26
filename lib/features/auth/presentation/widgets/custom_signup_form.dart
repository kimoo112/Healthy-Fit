import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

import '../../../../core/routes/functions/navigation_functions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../cubit/auth_cubit.dart';

class CustomSignupForm extends StatefulWidget {
  const CustomSignupForm({
    super.key,
  });

  @override
  State<CustomSignupForm> createState() => _CustomSignupFormState();
}

class _CustomSignupFormState extends State<CustomSignupForm> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(
                  content: Text(
                      'Registration successful! Please log in to continue.')))
              .close;
          customReplacementNavigate(context, login);
        } else if (state is SignUpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errMsg),
          ));
        }
      },
      builder: (context, state) {
        GlobalKey<FormState> formKey = GlobalKey();
        return Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Create Your Account',
                    style: CustomTextStyles.poppinsStyle20Bold,
                  ),
                  10.verticalSpace,
                  Text(
                    'Sign up to access all features and start achieving your fitness goals.',
                    style: CustomTextStyles.poppins400Style12Grey,
                    textAlign: TextAlign.center,
                  ),
                  40.verticalSpace,
                  CustomTextFormField(
                    controller: context.read<AuthCubit>().signupName,
                    isHavePrefix: false,
                    hintText: 'Name',
                    suffixIcon: Icon(
                      IconlyLight.profile,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  30.verticalSpace,
                  CustomTextFormField(
                    controller: context.read<AuthCubit>().signupEmail,
                    isHavePrefix: false,
                    hintText: 'Email',
                    suffixIcon: Icon(
                      IconlyLight.message,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  30.verticalSpace,
                  CustomTextFormField(
                    isHavePrefix: false,
                    controller: context.read<AuthCubit>().signupPassword,
                    obscureText: true,
                    hintText: 'Password',
                    suffixIcon: Icon(
                      IconlyLight.lock,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  30.verticalSpace,
                  CustomTextFormField(
                    isHavePrefix: false,
                    obscureText: true,
                    controller: context.read<AuthCubit>().signupConfirmPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm Password is required';
                      }
                      if (value !=
                          context.read<AuthCubit>().signupPassword.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    hintText: 'Confirm Password',
                    suffixIcon: Icon(
                      IconlyLight.lock,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  50.verticalSpace,
                  state is SignUpLoading
                      ? CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        )
                      : CustomButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await context.read<AuthCubit>().signup();
                            }
                          },
                          marginSize: 0,
                          text: 'SIGNUP',
                          textColor: AppColors.white,
                          borderRadius: 25.r,
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
