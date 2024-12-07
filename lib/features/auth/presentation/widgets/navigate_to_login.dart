import 'package:flutter/material.dart';
import 'package:healthy_fit/core/routes/functions/navigation_functions.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';

class NavigateToLogin extends StatelessWidget {
  const NavigateToLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already Have an Account ?'),
        TextButton(
          onPressed: () {
            customReplacementNavigate(context, login);
          },
          child: Text(
            'Login',
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
