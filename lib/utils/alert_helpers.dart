import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/components/alert_dialog_component.dart';

class AlertHelper {
  void showAlert(message) {
    Get.back();
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialogComponent(message: message);
        });
  }
}
