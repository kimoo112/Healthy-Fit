import 'package:flutter/material.dart';
import 'package:healthy_fit/core/routes/functions/navigation_functions.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';

class NavigateToSignUp extends StatelessWidget {
  const NavigateToSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don’t have an account?'),
        TextButton(
          onPressed: () {
            customReplacementNavigate(context, signup);
          },
          child: Text(
            'Sign Up',
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
