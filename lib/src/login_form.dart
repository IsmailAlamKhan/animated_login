import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import 'package:animated_login/src/login_controller.dart';
import 'package:animated_login/text_field.dart';

class AuthForm extends StatelessWidget {
  AuthForm({
    Key key,
    @required this.controller,
    this.afterSubmitAnimationCompletes,
    this.loginFunction,
    this.signUpFunction,
    this.forgotPassFunction,
  }) : super(key: key);
  final AuthFormController controller;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  // final GetStorage box = GetStorage();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();

  final FocusNode conpasswordFocusNode = FocusNode();
  final FocusNode regTypeFocusNode = FocusNode();
  final Function afterSubmitAnimationCompletes;
  final Function loginFunction;
  final Function signUpFunction;
  final Function forgotPassFunction;

  final passwordFocusNode = AuthFormController.to.passWordFocusNode;
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => AnimatedSwitcher(
                duration: controller.animDuration,
                child: Text(
                  controller.title.value,
                  key: ValueKey(controller.title.value),
                  style: TextStyle(
                    color: context.theme.accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          _buildUserName(),
          _buildName(),
          _buildEmail(),
          _buildPassword(context),
          _buildConPass(),
          _buildForgotPassButton(),
          _buildSubmitButton(context),
          controller.authState.value != 3 ? _buildSignUpButton() : SizedBox(),
        ],
      ),
    );
  }

  Widget _buildName() {
    return SizeTransition(
      sizeFactor: controller.nameSizeAnimation,
      child: SlideTransition(
        position: controller.nameSlideAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: _buildNameTextField(),
        ),
      ),
    );
  }

  Widget _buildUserName() {
    return SizeTransition(
      sizeFactor: controller.userNameSizeAnimation,
      child: SlideTransition(
        position: controller.userNameSlideAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: _buildNameTextField(userName: true),
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return SizeTransition(
      sizeFactor: controller.emailSizeAnimation,
      child: SlideTransition(
        position: controller.emailSlideAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: _buildEmailTextField(),
        ),
      ),
    );
  }

  Widget _buildPassword(BuildContext context) {
    return SizeTransition(
      sizeFactor: controller.forgotPassSizeAnimation,
      child: SlideTransition(
        position: controller.passwordSlideAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: _buildPassWordTextField(context),
        ),
      ),
    );
  }

  Widget _buildConPass() {
    return SizeTransition(
      sizeFactor: controller.conPassSizeAnimation,
      child: SlideTransition(
        position: controller.conPassSlideAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 20,
          ),
          child: _buildConPassTextField(),
        ),
      ),
    );
  }

  Widget _buildForgotPassButton() {
    return Obx(
      () => AbsorbPointer(
        absorbing: controller.loadingState.value != 0,
        child: AnimatedPadding(
          duration: controller.animDuration,
          padding: EdgeInsets.symmetric(
            vertical: controller.authState.value == 0 ? 10 : 0,
          ),
          child: AbsorbPointer(
            absorbing: controller.authState.value == 1,
            child: SlideTransition(
              position: controller.forgotPassButtonSlideAnimation,
              child: TextButton(
                onPressed: () {
                  controller.title('Type your email to reset your password');

                  controller.forgotPassController.reverse();
                  controller.forgotPassButtonController.reverse();
                  controller.userNameController.reverse();
                  controller.regTypeController.reverse();
                  controller.emailController.forward();
                  controller.authState(2);
                  //controller.update();
                  controller.submitBTNText('Recover');
                  controller.signUpButtonTXT('Back');
                },
                child: Text(
                  'Forgot Password',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return SizeTransition(
      sizeFactor: controller.signUpButtonSizeAnimation,
      child: SlideTransition(
        position: controller.signUpButtonSlideAnimation,
        child: Center(
          child: Obx(
            () => AbsorbPointer(
              absorbing: controller.loadingState.value != 0,
              child: TextButton(
                child: AnimatedSwitcher(
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  duration: controller.animDuration,
                  transitionBuilder: (child, animation) {
                    final offsetAnim = Tween<Offset>(
                      begin: Offset(0.0, -3.0),
                      end: Offset(0.0, 0.0),
                    ).animate(animation);
                    return SlideTransition(
                      child: child,
                      position: offsetAnim,
                    );
                  },
                  child: Text(
                    controller.signUpButtonTXT.value,
                    key: ValueKey<String>(
                      controller.signUpButtonTXT.value,
                    ),
                  ),
                ),
                onPressed: () {
                  formKey.currentState?.reset();
                  if (controller.authState.value == 0) {
                    // *Now Login
                    controller.forgotPassButtonController.reverse();
                    controller.userNameController.forward();
                    controller.nameController.forward();
                    controller.emailController.forward();
                    controller.regTypeController.forward();
                    controller.conPassController.forward();
                    controller.authState(1);
                    //controller.update();
                    controller.submitBTNText('Sign Up');
                    controller.signUpButtonTXT('Back');
                    controller.title('Sign Up');
                  } else if (controller.authState.value == 2) {
                    // *Now Forgot Password
                    controller.authState(0);
                    controller.forgotPassButtonController.forward();
                    controller.emailController.reverse();
                    controller.nameController.reverse();
                    controller.forgotPassController.forward();
                    controller.userNameController.forward();
                    //controller.update();
                    controller.regTypeController.reverse();
                    controller.conPassController.reverse();
                    controller.submitBTNText('Login');
                    controller.signUpButtonTXT('Sign Up');
                    controller.title('Login');
                  } else if (controller.authState.value == 1) {
                    // *Now Signup
                    controller.forgotPassButtonController.forward();
                    controller.userNameController.forward();
                    controller.regTypeController.reverse();
                    controller.conPassController.reverse();
                    controller.emailController.reverse();
                    controller.nameController.reverse();
                    //controller.update();
                    controller.authState(0);
                    controller.title('Login');
                    controller.submitBTNText('Login');
                    controller.signUpButtonTXT('Sign Up');
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return SizeTransition(
      sizeFactor: controller.submitButtonSizeAnimation,
      child: SlideTransition(
        position: controller.submitButtonSlideAnimation,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: Obx(
              () => AbsorbPointer(
                absorbing: controller.loadingState.value != 0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.elasticInOut,
                  height: controller.submitBTNheight.value,
                  width: controller.submitBTNwidth.value,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    color: controller.loadingState.value == 2
                        ? Colors.green
                        : controller.loadingState.value == 3
                            ? Theme.of(context).errorColor
                            : Theme.of(context).primaryColor,
                    padding: EdgeInsets.zero,
                    child: AnimatedSwitcher(
                      transitionBuilder: (child, animation) {
                        final offsetAnim = Tween<Offset>(
                          begin: Offset(0.0, -3.0),
                          end: Offset(0.0, 0.0),
                        ).animate(animation);
                        return SlideTransition(
                          child: child,
                          position: offsetAnim,
                        );
                      },
                      duration: controller.animDuration,
                      child: controller.loadingState.value == 0
                          ? _buildSubmitText()
                          : _buildLoadingState(),
                    ),
                    onPressed: () {
                      controller.submit(
                        loginFunction: loginFunction,
                        signUpFunction: signUpFunction,
                        forgotPassFunction: forgotPassFunction,
                        afterSubmitAnimationCompletes:
                            afterSubmitAnimationCompletes,
                        context: context,
                        formKey: formKey,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Obx(
      () => AnimatedCrossFade(
        crossFadeState: controller.loadingState.value == 1
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: controller.animDuration,
        firstCurve: Curves.easeIn,
        secondCurve: Curves.easeIn,
        firstChild: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            value: null,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        secondChild: Icon(
          controller.loadingState.value == 2 ? Icons.check : Icons.close,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSubmitText() {
    return AnimatedSwitcher(
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      duration: Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        final offsetAnim = Tween<Offset>(
          begin: Offset(0.0, -3.0),
          end: Offset(0.0, 0.0),
        ).animate(animation);
        return SlideTransition(
          child: child,
          position: offsetAnim,
        );
      },
      child: Text(
        controller.submitBTNText.value,
        key: ValueKey<String>(
          controller.submitBTNText.value,
        ),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildNameTextField({bool userName = false}) {
    return _TextField(
      currentFocus: !userName ? nameFocusNode : userNameFocusNode,
      nextFocus: !userName
          ? emailFocusNode
          : controller.authState.value == 1
              ? nameFocusNode
              : passwordFocusNode,
      validators: [
        (val) {
          if (!userName) {
            if (controller.authState.value == 1) {
              if (val == '') return 'Please enter your "Fullname".';
              return null;
            }
          }
          if (controller.authState.value == 1 ||
              controller.authState.value == 0 && userName) {
            if (val == '') return 'Please enter your "Username".';
            if (controller.authState.value != 0) {
              if (val.length < 6) {
                return 'Username must be six charecters long.';
              }
              if (val.length > 15) {
                return 'Username must be smaller than 15 charecters.';
              }
            }
            return null;
          }
          return null;
        }
      ],
      // validators: [],
      attribute: !userName ? "fullName" : "userName",
      icon: Icon(
        Icons.account_circle_sharp,
        size: 30,
      ),
      isPassword: false,
      label: !userName ? "FullName" : "Username",
    );
  }

  Widget _buildEmailTextField() {
    return Obx(
      () => _TextField(
        currentFocus: emailFocusNode,
        nextFocus: passwordFocusNode,
        onFieldSubmitted: controller.authState.value == 2
            ? (_) {
                controller.submit(
                  context: Get.context,
                  formKey: formKey,
                );
              }
            : null,
        isEmail: true,
        controller: controller.emailTEC,
        validators:
            controller.authState.value == 3 || controller.authState.value == 1
                ? [
                    FormBuilderValidators.required(Get.context,
                        errorText: 'Email is required'),
                    FormBuilderValidators.email(
                      Get.context,
                      errorText: 'Not a valid Email Address',
                    ),
                  ]
                : [],
        attribute: "email",
        icon: Icon(
          Icons.email,
          size: 30,
        ),
        isPassword: false,
        label: "Email",
      ),
    );
  }

  Widget _buildPassWordTextField(BuildContext context) {
    String _validatePassword(String value) {
      bool _eightChars = value.length >= 8;
      bool _number = value.contains(RegExp(r'\d'), 0);
      bool _upperCaseChar = value.contains(new RegExp(r'[A-Z]'), 0);
      bool _specialChar =
          value.isNotEmpty && !value.contains(RegExp(r'^[\w&.-]+$'), 0);
      if (value.length == 0) {
        //FocusScope.of(context).requestFocus(focusFromNode);
        return "${controller.passWordText} is Required";
      } else if (controller.authState.value == 1 ||
          controller.authState.value == 3) {
        if (!_eightChars) {
          return "${controller.passWordText} must be 8 character";
        } else if (!_number) {
          //FocusScope.of(context).requestFocus(focusFromNode);
          return "${controller.passWordText} must contain one digit";
        } else if (!_specialChar) {
          //FocusScope.of(context).requestFocus(focusFromNode);
          return "${controller.passWordText} must contain one special character";
        } else if (!_upperCaseChar) {
          //FocusScope.of(context).requestFocus(focusFromNode);
          return "${controller.passWordText} must contain one uppercase character";
        }
      }
      return null;
    }

    return Obx(
      () => _TextField(
        currentFocus: passwordFocusNode,
        nextFocus: conpasswordFocusNode,
        onFieldSubmitted: controller.authState.value == 0
            ? (value) {
                controller.submit(
                  context: context,
                  formKey: formKey,
                );
              }
            : null,
        validators: [
          (val) {
            if (controller.authState.value != 2 &&
                controller.authState.value <= 3) {
              return _validatePassword(val);
            } else {
              return null;
            }
          }
        ],
        attribute: "password",
        isPassword: true,
        obsecure: controller.obsecure.value,
        label: controller.passWordText,
        showPass: () => controller.obsecure(false),
        hidePass: () => controller.obsecure(true),
      ),
    );
  }

  Widget _buildConPassTextField() {
    return Obx(
      () => _TextField(
        currentFocus: conpasswordFocusNode,
        nextFocus: regTypeFocusNode,
        validators: controller.authState.value == 1 ||
                controller.authState.value == 3
            ? [
                FormBuilderValidators.required(
                  Get.context,
                  errorText: 'Please confirm your Password',
                ),
                FormBuilderValidators.equal(
                    Get.context, formKey.currentState.fields['password'].value),
              ]
            : [],
        attribute: "con_password",
        isPassword: true,
        obsecure: controller.conobsecure.value,
        label: "Confirm Password",
        showPass: () => controller.conobsecure(false),
        hidePass: () => controller.conobsecure(true),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  _TextField({
    Key key,
    this.attribute,
    this.label,
    this.isPassword,
    this.icon,
    this.hidePass,
    this.showPass,
    this.obsecure = false,
    this.validators,
    this.initialValue,
    this.onChanged,
    this.currentFocus,
    this.nextFocus,
    this.onFieldSubmitted,
    this.controller,
    this.isEmail = false,
  }) : super(key: key);

  final String attribute, label, initialValue;
  final TextEditingController controller;
  final bool isPassword, obsecure, isEmail;
  final Widget icon;

  final List<FormFieldValidator> validators;
  final Function onChanged, hidePass, showPass;

  final FocusNode currentFocus, nextFocus;
  final ValueChanged<String> onFieldSubmitted;

  _fieldFocusChange({
    @required BuildContext context,
    @required FocusNode currentFocus,
    @required FocusNode nextFocus,
  }) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    if (!isEmail)
      return GlobalTextField(
        autoValidateMode: AutovalidateMode.onUserInteraction,
        // textFieldColor: Colors.black,
        prefixIcon: icon,
        brightness: Brightness.light,
        focusNode: currentFocus,
        submit: onFieldSubmitted == null
            ? (val) {
                _fieldFocusChange(
                  currentFocus: currentFocus,
                  nextFocus: nextFocus,
                  context: context,
                );
              }
            : onFieldSubmitted,
        initialVal: initialValue,
        attribute: attribute,
        changed: onChanged,
        validators: validators,
        isPassWord: isPassword,
        showPass: showPass,
        hidePass: hidePass,
        label: label,
        obscure: obsecure,
      );
    else
      return GlobalTextField(
        autoValidateMode: AutovalidateMode.onUserInteraction,
        // textFieldColor: Colors.black,
        brightness: Brightness.light,
        focusNode: currentFocus,
        submit: onFieldSubmitted == null
            ? (val) {
                _fieldFocusChange(
                  currentFocus: currentFocus,
                  nextFocus: nextFocus,
                  context: context,
                );
              }
            : onFieldSubmitted,
        tec: controller,
        attribute: attribute,
        changed: onChanged,
        validators: validators,
        prefixIcon: Icon(
          Icons.email,
          size: 30,
        ),
        label: label,
      );
  }
}
