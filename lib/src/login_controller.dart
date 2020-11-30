import 'package:animated_login/animatedlogin.dart';
import 'package:animated_login/constants.dart';
import 'package:animated_login/src/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

typedef AuthCallback = Future<String> Function(LoginModel);

class Auth {
  final AuthCallback loginFunction;
  final AuthCallback signUpFunction;
  final AuthCallback forgotPassFunction;

  Auth({this.loginFunction, this.signUpFunction, this.forgotPassFunction});
}

class AuthFormController extends GetxController
    with SingleGetTickerProviderMixin {
  final auth = Auth();
  static AuthFormController to = Get.find();
  @override
  void onInit() async {
    super.onInit();

    animInit();
  }

  @override
  void onClose() async {
    super.onClose();
    emailController.dispose();
    nameController.dispose();
    userNameController.dispose();
    forgotPassController.dispose();
    conPassController.dispose();
    forgotPassButtonController.dispose();
    regTypeController.dispose();
    submitButtonController.dispose();
    signUpButtonController.dispose();
  }

  // *Anim Stuff
  AnimationController get initAnimController {
    return AnimationController(
      vsync: this,
      duration: animDuration,
    );
  }

  Animatable<double> get initCardAnims {
    return Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: animCurve));
  }

  Tween<double> get initDoubleAnims {
    return Tween<double>(
      begin: 0.0,
      end: 1.0,
    );
  }

  Tween<Offset> get initOffsetAnims {
    return Tween<Offset>(
      begin: const Offset(-1, 0),
      end: const Offset(0, 0),
    );
  }

  Tween<Offset> get initOffsetAnimsForButton {
    return Tween<Offset>(
      begin: const Offset(-3, 0),
      end: const Offset(0, 0),
    );
  }

  CurvedAnimation doubleCurveAnimations(AnimationController anim) {
    return CurvedAnimation(
      parent: anim,
      curve: const Interval(0.0, .6875, curve: Curves.bounceOut),
      reverseCurve: const Interval(0.0, .6875, curve: Curves.bounceIn),
    );
  }

  CurvedAnimation offsetCurveAnimations(AnimationController anim) {
    return CurvedAnimation(
      parent: anim,
      curve: const Interval(.6875, 1.0, curve: Curves.fastOutSlowIn),
    );
  }

  AnimationController cardinitController;
  Animation cardinitAnimation;
  AnimationController cardOffsetController;
  Animation<Offset> cardOffsettAnimation;
  Duration animDuration = 800.milliseconds;
  Curve animCurve = Curves.easeInOut;

  /// 0 = [Login] 1 = [Signup] 2 = [Forgot Pass]
  final authState = 0.obs;

  /// 0 = [idle] 1 = [Loading] 2 = [Success] 3 = [Error]
  final loadingState = 0.obs;

  final submitBTNText = 'signUp'.obs;
  final submitBTNheight = 40.0.obs;
  final submitBTNwidth = 150.0.obs;
  final signUpButtonTXT = 'Sign Up'.obs;
  final title = 'signUp With Email and Password'.obs;

  AnimationController emailController;
  Animation<Offset> emailSlideAnimation;
  Animation<double> emailSizeAnimation;

  AnimationController userNameController;
  Animation<Offset> userNameSlideAnimation;
  Animation<double> userNameSizeAnimation;

  AnimationController nameController;
  Animation<Offset> nameSlideAnimation;
  Animation<double> nameSizeAnimation;

  AnimationController forgotPassController;
  Animation<double> forgotPassSizeAnimation;
  Animation<Offset> passwordSlideAnimation;

  AnimationController conPassController;
  Animation<double> conPassSizeAnimation;
  Animation<Offset> conPassSlideAnimation;

  AnimationController forgotPassButtonController;
  Animation<double> forgotPassButtonSizeAnimation;
  Animation<Offset> forgotPassButtonSlideAnimation;

  AnimationController submitButtonController;
  Animation<double> submitButtonSizeAnimation;
  Animation<Offset> submitButtonSlideAnimation;

  AnimationController signUpButtonController;
  Animation<double> signUpButtonSizeAnimation;
  Animation<Offset> signUpButtonSlideAnimation;

  AnimationController regTypeController;
  Animation<Offset> regTypeSlideAnimation;
  Animation<double> regTypeSizeAnimation;

  void animInit() {
    cardinitController = initAnimController;
    cardinitAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: animCurve))
        .animate(cardinitController);

    forgotPassButtonController = initAnimController;
    forgotPassButtonSizeAnimation = initDoubleAnims.animate(
      doubleCurveAnimations(forgotPassButtonController),
    );
    forgotPassButtonSlideAnimation = initOffsetAnimsForButton.animate(
      offsetCurveAnimations(forgotPassButtonController),
    );

    cardOffsetController = initAnimController;
    cardOffsettAnimation =
        Tween<Offset>(begin: Offset(-10, 0), end: Offset(0, 0))
            .animate(cardOffsetController);

    userNameController = initAnimController;
    userNameSizeAnimation = initDoubleAnims.animate(
      doubleCurveAnimations(userNameController),
    );
    userNameSlideAnimation = initOffsetAnims.animate(
      offsetCurveAnimations(userNameController),
    );

    signUpButtonController = initAnimController;
    signUpButtonSizeAnimation = initDoubleAnims.animate(
      doubleCurveAnimations(userNameController),
    );
    signUpButtonSlideAnimation = initOffsetAnims.animate(
      offsetCurveAnimations(userNameController),
    );

    submitButtonController = initAnimController;
    submitButtonSizeAnimation = initDoubleAnims.animate(
      doubleCurveAnimations(userNameController),
    );
    submitButtonSlideAnimation = initOffsetAnims.animate(
      offsetCurveAnimations(userNameController),
    );

    nameController = initAnimController;
    nameSizeAnimation = initDoubleAnims.animate(
      doubleCurveAnimations(nameController),
    );
    nameSlideAnimation = initOffsetAnims.animate(
      offsetCurveAnimations(nameController),
    );

    forgotPassController = initAnimController;
    forgotPassSizeAnimation = initDoubleAnims.animate(
      doubleCurveAnimations(forgotPassController),
    );

    passwordSlideAnimation = initOffsetAnims.animate(
      offsetCurveAnimations(forgotPassController),
    );

    conPassController = initAnimController;
    conPassSizeAnimation = initDoubleAnims.animate(
      doubleCurveAnimations(conPassController),
    );

    conPassSlideAnimation = initOffsetAnims.animate(
      offsetCurveAnimations(conPassController),
    );

    emailController = initAnimController;
    emailSizeAnimation = initDoubleAnims.animate(
      doubleCurveAnimations(emailController),
    );
    emailSlideAnimation = initOffsetAnims.animate(
      offsetCurveAnimations(emailController),
    );

    regTypeController = initAnimController;
    regTypeSizeAnimation = initDoubleAnims.animate(
      doubleCurveAnimations(regTypeController),
    );
    regTypeSlideAnimation = initOffsetAnims.animate(
      offsetCurveAnimations(regTypeController),
    );
  }

  // *Anim Stuff

  List<String> regTypeString = List<String>();
  final String code = Get.parameters['oobCode'];
  String passWordText = 'Password';
  TextEditingController emailTEC;
  final FocusNode passWordFocusNode = FocusNode();
  final obsecure = true.obs;
  final conobsecure = true.obs;

//*Submit Stuff
  void signUp({
    Function afterAnimationCompletes,
    Function auth,
  }) async {
    try {
      auth();
      afterAuth(
        afterAnimationCompletes: afterAnimationCompletes,
      );
    } catch (e) {
      showErrorSnackBar(body: e.toString());
    }
  }

  void login({
    Function afterAnimationCompletes,
    Function auth,
  }) async {
    try {
      auth();
      afterAuth(
        afterAnimationCompletes: afterAnimationCompletes,
      );
    } catch (e) {
      showErrorSnackBar(body: e.toString());
    }
  }

  void forgotPass({
    Function afterAnimationCompletes,
    Function auth,
  }) async {
    try {
      auth();
      authState(0);
      forgotPassButtonController.forward();
      emailController.reverse();
      nameController.reverse();
      forgotPassController.forward();
      userNameController.forward();
      conPassController.reverse();
      submitBTNText('Login');
      signUpButtonTXT('Sign Up');
      title('Login');
    } catch (e) {
      showErrorSnackBar(body: e.toString());
    }
  }

  void afterAuth({Function afterAnimationCompletes}) {
    successButton(() async {
      await Future.delayed(700.milliseconds);
      // if (afterAnimationCompletes != null) afterAnimationCompletes();
    });
  }

  Future<bool> submit({
    GlobalKey<FormBuilderState> formKey,
    BuildContext context,
    String invalidMessege,
    bool emailBasedLogin = true,
    Function afterSubmitAnimationCompletes,
    AuthCallback loginFunction,
    AuthCallback signUpFunction,
    AuthCallback forgotPassFunction,
  }) async {
    if (!formKey.currentState.saveAndValidate()) {
      if (!Get.isSnackbarOpen)
        showErrorSnackBar(
          body: invalidMessege ?? 'Please fill all the mandatory fields',
        );
      return false;
    } else {
      final String password = formKey.currentState.fields['password'].value;
      final String email = formKey.currentState.fields['email'].value;
      final String fullName = formKey.currentState.fields['fullName'].value;
      final String userName = formKey.currentState.fields['userName'].value;
      LoginModel _login;
      if (emailBasedLogin)
        _login = LoginModel(
          password: password,
          username: userName,
        );
      else
        _login = LoginModel(
          password: password,
          email: email,
        );

      final _signUp = LoginModel(
        email: email,
        fullname: fullName,
        password: password,
        username: userName,
      );

      final _forgotPass = LoginModel(
        email: email,
      );
      submitBTNwidth(
        submitBTNwidth.value - ((submitBTNwidth.value - 40.0) * 1),
      );
      loadingState(1);
      String error;
      await Future.delayed(
        1000.milliseconds,
      );
      if (authState.value == 0) {
        error = await loginFunction(_login);
      }
      if (authState.value == 1) {
        error = await signUpFunction(_signUp);
      }
      if (authState.value == 2) {
        error = await forgotPassFunction(_forgotPass);
      }
      if (!error.isNullOrBlank) {
        afterAuth(
          afterAnimationCompletes: afterSubmitAnimationCompletes,
        );
        return false;
      } else {
        errorButton();
        showErrorSnackBar(body: error);
        return true;
      }
    }
  }

  void buttonReset() {
    submitBTNwidth(150);
    loadingState(0);
  }

  void errorButton() {
    loadingState(3);
    Future.delayed(Duration(milliseconds: 1000), () {
      buttonReset();
    });
  }

  Future<void> successButton(Function start) async {
    loadingState(2);
    userNameController.reverse();
    nameController.reverse();
    emailController.reverse();
    conPassController.reverse();
    forgotPassController.reverse();
    forgotPassButtonController.reverse();
    await Future.delayed(300.milliseconds);
    regTypeController.reverse();
    cardinitController.reverse();
    await Future.delayed(700.milliseconds);
    buttonReset();
    start();
  }

  Future<void> reset() async {
    emailController.reverse();
    nameController.reverse();
    userNameController.reverse();
    forgotPassController.reverse();
    conPassController.reverse();
    forgotPassButtonController.reverse();
    regTypeController.reverse();
    submitButtonController.reverse();
    signUpButtonController.reverse();

    submitBTNText('');
    title('');
    signUpButtonTXT('');
    await Future.delayed(300.milliseconds);
    regTypeController.reverse();
    cardinitController.reverse();
    await Future.delayed(700.milliseconds);
  }

  //*Submit Stuff
}
