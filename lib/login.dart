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
  final InputDecorationTheme decoration;

  const AnimatedLogin({
    Key key,
    this.logo,
    @required this.title,
    @required this.loginFunction,
    this.signUpFunction,
    this.forgotPassFunction,
    @required this.afterSubmitAnimationCompletes,
    this.wantLogo = true,
    this.wantForgorPass = true,
    this.wantSignup = true,
    this.emailBasedLogin = true,
    this.decoration,
  })  : assert(
          !wantLogo || logo == null,
          'If you want logo must provide a path to your logo',
        ),
        assert(
          wantSignup || signUpFunction == null,
          'If you want Signup must provide a SignupFunction',
        ),
        assert(
          wantForgorPass || forgotPassFunction == null,
          'If you want Forgot Pass must provide a ForgotPasswordFunction',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      decoration: decoration,
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
