import 'package:flutter/material.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/components/button_alert_component.dart';

class ConfirmDialogComponent extends StatelessWidget {
  final String message;
  final InkWell confirm;
  const ConfirmDialogComponent(
      {super.key, required this.message, required this.confirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: ColorPicker.white),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  message,
                  style: const TextStyle(
                    fontFamily: FontPicker.medium,
                    color: ColorPicker.dark,
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const ButtonAlertComponent(
                        text: 'Close', colors: ColorPicker.danger)),
                const SizedBox(
                  width: 10,
                ),
                confirm
              ],
            ),
          ],
        ),
      ),
    );
  }
}
