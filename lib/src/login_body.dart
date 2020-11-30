import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:animated_login/src/login_controller.dart';
import 'package:animated_login/src/login_form.dart';

class AuthPage extends GetView<AuthFormController> {
  AuthPage({
    this.logo,
    this.title,
    this.loginFunction,
    this.signUpFunction,
    this.forgotPassFunction,
    this.afterSubmitAnimationCompletes,
    this.wantLogo = true,
  });

  final String logo;
  final String title;
  final Function loginFunction;
  final Function signUpFunction;
  final Function forgotPassFunction;
  final Function afterSubmitAnimationCompletes;
  final bool wantLogo;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<AuthFormController>(() => AuthFormController());
    controller.cardinitController.forward();
    controller.cardOffsetController.forward();
    Future.microtask(() {
      if (Get.currentRoute.contains('reset')) controller.authState(3);
      controller.submitButtonController.forward();
      controller.signUpButtonController.forward();
      if (controller.authState.value == 0) {
        controller.submitBTNText('Login');
        controller.signUpButtonTXT('Sign Up');
        controller.title('Login');
        controller.passWordText = 'Password';
        controller.emailController.reverse();
        controller.forgotPassController.forward();
        controller.forgotPassButtonController.forward();
        controller.nameController.reverse();
        controller.userNameController.forward();
        controller.regTypeController.reverse();
        controller.conPassController.reverse();
      } else if (controller.authState.value == 1) {
        controller.submitBTNText('Sign Up');
        controller.signUpButtonTXT('Back');
        controller.title('Sign Up');
        controller.passWordText = 'Password';
        controller.emailController.forward();
        controller.forgotPassController.forward();
        controller.forgotPassButtonController.reverse();
        controller.userNameController.forward();
        controller.nameController.forward();
        controller.regTypeController.forward();
        controller.conPassController.forward();
      } else if (controller.authState.value == 2) {
        controller.title('Type your email to reset your password');
        controller.submitBTNText('Recover');
        controller.passWordText = 'Password';
        controller.signUpButtonTXT('Back');
        controller.emailController.forward();
        controller.forgotPassController.reverse();
        controller.forgotPassButtonController.reverse();
        controller.nameController.reverse();
        controller.userNameController.reverse();
        controller.regTypeController.reverse();
        controller.conPassController.reverse();
      } else {
        controller.title('Enter and Confirm your new password');
        controller.submitBTNText('Submit');
        controller.passWordText = 'New Password';
        controller.signUpButtonTXT('Back');
        controller.emailController.reverse();
        controller.nameController.reverse();
        controller.forgotPassController.forward();
        controller.conPassController.forward();
        controller.forgotPassButtonController.reverse();
        controller.userNameController.reverse();
        controller.regTypeController.reverse();
      }
      controller.buttonReset();
    });
    return _build();
  }

  Widget _build() {
    return Scaffold(
      backgroundColor: Theme.of(Get.context).primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TweenAnimationBuilder(
                duration: Duration(seconds: 2),
                curve: controller.animCurve,
                tween: Tween<double>(begin: -800, end: 0),
                builder: (_, double yOffset, __) {
                  return Transform.translate(
                    offset: Offset(0.0, yOffset),
                    child: Column(
                      children: [
                        wantLogo
                            ? Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 20,
                                ),
                                child: Image.asset(
                                  logo,
                                  height: 100,
                                  width: 200,
                                ),
                              )
                            : SizedBox.shrink(),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Get.context.width > 1000 ? 30 : 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              AnimatedBuilder(
                animation: controller.cardinitAnimation,
                builder: (context, animation) {
                  return ScaleTransition(
                    scale: controller.cardinitAnimation,
                    child: SlideTransition(
                      position: controller.cardOffsettAnimation,
                      child: AnimatedContainer(
                        transform: Matrix4.translationValues(
                          0,
                          0,
                          0,
                        ),
                        duration: Duration(seconds: 1),
                        curve: controller.animCurve,
                        width: 360,
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: AuthForm(
                                loginFunction: loginFunction,
                                signUpFunction: signUpFunction,
                                forgotPassFunction: forgotPassFunction,
                                afterSubmitAnimationCompletes:
                                    afterSubmitAnimationCompletes,
                                controller: controller,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
