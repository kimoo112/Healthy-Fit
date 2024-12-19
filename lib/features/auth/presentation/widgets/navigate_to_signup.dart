import 'package:flutter/material.dart';
import 'package:healthy_fit/core/routes/functions/navigation_functions.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/utils/app_colors.dart';

class NavigateToRegister extends StatelessWidget {
  const NavigateToRegister({
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
            customReplacementNavigate(context, genderView);
          },
          child: Text(
            'Register Now',
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
