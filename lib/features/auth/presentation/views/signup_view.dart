import 'package:flutter/material.dart';
import 'package:healthy_fit/core/widgets/green_slogan.dart';
import 'package:healthy_fit/core/widgets/top_right_vectors.dart';

import '../widgets/custom_signup_form.dart';
import '../widgets/navigate_to_login.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          GreenSlogan(),
          TopRightVectors(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CustomSignupForm(), NavigateToLogin()],
          ),
        ],
      ),
    );
  }
}
