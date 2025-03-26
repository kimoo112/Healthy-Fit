import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_fit/core/routes/functions/navigation_functions.dart';
import 'package:healthy_fit/core/routes/routes.dart';
import 'package:healthy_fit/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:iconly/iconly.dart';
import 'package:screenutil_module/main.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class CustomLoginForm extends StatelessWidget {
  const CustomLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Success')))
              .close;
          customReplacementAndRemove(context, appNavigation);
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
          ));
        }
      },
      builder: (context, state) {
        GlobalKey<FormState> formKey = GlobalKey();
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomTextFormField(
                isHavePrefix: false,
                controller: context.read<AuthCubit>().loginEmail,
                hintText: 'Email',
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
                suffixIcon: Icon(
                  IconlyLight.message,
                  color: AppColors.primaryColor,
                ),
              ),
              30.verticalSpace,
              CustomTextFormField(
                isHavePrefix: false,
                obscureText: true,
                controller: context.read<AuthCubit>().loginPassword,
                hintText: 'password',
                suffixIcon: Icon(
                  IconlyLight.lock,
                  color: AppColors.primaryColor,
                ),
              ),
              10.verticalSpace,
              TextButton(
                onPressed: () {
                  customNavigate(context, forgetPasswordView);
                },
                child: Text(
                  "Forget Password !",
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
              30.verticalSpace,
              state is LoginLoading
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                    ],
                  )
                  : CustomButton(
                      marginSize: 0,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await context.read<AuthCubit>().login();
                        }
                      },
                      text: 'Login',
                      textColor: AppColors.white,
                      borderRadius: 25.r,
                    )
            ],
          ),
        );
      },
    );
  }
}
