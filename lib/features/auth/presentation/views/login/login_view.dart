import 'package:flutter/material.dart';

import '../../../../../core/widgets/green_slogan.dart';
import '../../../../../core/widgets/top_right_vectors.dart';
import '../../widgets/custom_login_form.dart';
import '../../widgets/navigate_to_signup.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Stack(
      children: [
        GreenSlogan(),
        TopRightVectors(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CustomLoginForm(),
            ),
            NavigateToRegister()
          ],
        ),
      ],
    ));
  }
}
