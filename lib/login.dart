import 'package:flutter/material.dart';

import 'animatedlogin.dart';
export 'animatedlogin.dart';

class AnimatedLogin extends StatelessWidget {
  final String logo;
  final String title;
  final bool emailBasedLogin;
  final Function(LoginModel model) loginFunction;
  final Function(LoginModel model) signUpFunction;
  final Function(LoginModel model) forgotPassFunction;
  final Function afterSubmitAnimationCompletes;
  final bool wantLogo;
  final bool wantForgorPass;
  final bool wantSignup;

  const AnimatedLogin({
    Key key,
    this.logo,
    @required this.title,
    @required this.loginFunction,
    @required this.signUpFunction,
    this.forgotPassFunction,
    @required this.afterSubmitAnimationCompletes,
    this.wantLogo = true,
    this.wantForgorPass = true,
    this.wantSignup = true,
    this.emailBasedLogin = true,
  })  : assert(
          !wantLogo || logo == null,
          'If you want logo must provide a path to your logo',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      forgotPassFunction: forgotPassFunction,
      loginFunction: loginFunction,
      wantForgorPass: wantForgorPass,
      wantSignup: wantSignup,
      logo: logo,
      signUpFunction: signUpFunction,
      emailBasedLogin: emailBasedLogin,
      afterSubmitAnimationCompletes: afterSubmitAnimationCompletes,
      wantLogo: wantLogo,
      title: title,
    );
  }
}
