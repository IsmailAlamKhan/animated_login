import 'package:flutter/material.dart';

import 'src/login.dart';

class AnimatedLogin extends StatelessWidget {
  final String logo;
  final String title;
  final Function loginFunction;
  final Function signUpFunction;
  final Function forgotPassFunction;
  final Function afterSubmitAnimationCompletes;
  final bool wantLogo;

  const AnimatedLogin({
    Key key,
    this.logo,
    @required this.title,
    @required this.loginFunction,
    @required this.signUpFunction,
    @required this.forgotPassFunction,
    @required this.afterSubmitAnimationCompletes,
    this.wantLogo = true,
  })  : assert(
          wantLogo || logo != null,
          'If you want logo must provide a path to your logo',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      forgotPassFunction: forgotPassFunction,
      loginFunction: loginFunction,
      logo: logo,
      signUpFunction: signUpFunction,
      afterSubmitAnimationCompletes: afterSubmitAnimationCompletes,
      wantLogo: wantLogo,
      title: title,
    );
  }
}
