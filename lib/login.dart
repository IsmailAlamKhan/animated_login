import 'package:flutter/material.dart';
import 'src/login.dart';

class AnimatedLogin extends StatelessWidget {
  final String logo;
  final String title;
  final Function loginFunction;
  final Function signUpFunction;
  final Function forgotPassFunction;

  const AnimatedLogin({
    Key key,
    this.logo,
    this.title,
    this.loginFunction,
    this.signUpFunction,
    this.forgotPassFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      forgotPassFunction: forgotPassFunction,
      loginFunction: loginFunction,
      logo: logo,
      signUpFunction: signUpFunction,
      title: title,
    );
  }
}
