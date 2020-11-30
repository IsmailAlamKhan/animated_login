import 'package:flutter/material.dart';
import 'package:get/get.dart';

final Color successColor = Color(0xFF4CAF50);
final Color errorColor = Color(0xFFF44336);

void showErrorSnackBar({
  @required String body,
}) {
  final BuildContext context = Get.context;
  try {
    Get.rawSnackbar(
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: errorColor,
      borderRadius: 5,
      messageText: Text(
        body,
        maxLines: 30,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      isDismissible: true,
      maxWidth: context.width,
      forwardAnimationCurve: Curves.easeInOut,
      barBlur: 20,
      margin: EdgeInsets.only(
        bottom: 30,
        left: 20,
        right: 20,
      ),
    );
  } catch (e) {
    return;
  }
}

void showSuccessSnackBar({
  @required String body,
}) {
  final BuildContext context = Get.context;
  try {
    Get.rawSnackbar(
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: successColor,
      borderRadius: 5,
      messageText: Text(
        body,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      isDismissible: true,
      maxWidth: context.width,
      forwardAnimationCurve: Curves.easeInOut,
      barBlur: 20,
      margin: EdgeInsets.only(
        bottom: 30,
        left: 20,
        right: 20,
      ),
    );
  } catch (e) {
    return;
  }
}
