import 'package:gofarmin_app/controllers/profile_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/components/button_component.dart';
import 'package:gofarmin_app/screens/components/header_account_component.dart';
import 'package:gofarmin_app/screens/components/input_component.dart';
import 'package:gofarmin_app/screens/components/label_component.dart';
import 'package:gofarmin_app/screens/farm_gov/accounts/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeFarmGovPasswordScreen extends StatefulWidget {
  const ChangeFarmGovPasswordScreen({super.key});

  @override
  State<ChangeFarmGovPasswordScreen> createState() =>
      _ChangeFarmGovPasswordScreenState();
}

class _ChangeFarmGovPasswordScreenState
    extends State<ChangeFarmGovPasswordScreen> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 25, bottom: 50, top: 50),
          child: Column(
            children: [
              HeaderAccountComponent(
                  inkWell: InkWell(
                onTap: () {
                  Get.off(const AccountFarmGovScreen());
                },
                child: Row(
                  children: const [
                    Icon(Icons.arrow_back_ios),
                    Text('Back'),
                  ],
                ),
              )),
              const SizedBox(
                height: 40,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Change Password',
                  style: TextStyle(
                      fontFamily: FontPicker.semibold,
                      fontSize: 18,
                      color: ColorPicker.dark),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const LabelComponent(label: 'Old Password : '),
              InputComponent(
                textEditingController: profileController.oldPasswordController,
                hintText: 'Enter your old password',
                obscuredText: true,
                colors: ColorPicker.greyAccent,
              ),
              const SizedBox(
                height: 10,
              ),
              const LabelComponent(label: 'New Password : '),
              InputComponent(
                textEditingController: profileController.passwordController,
                hintText: 'Enter your new password',
                obscuredText: true,
                colors: ColorPicker.greyAccent,
              ),
              const SizedBox(
                height: 10,
              ),
              const LabelComponent(label: 'Confirm Password : '),
              InputComponent(
                textEditingController:
                    profileController.passwordConfirmationController,
                hintText: 'Enter your confirm password',
                obscuredText: true,
                colors: ColorPicker.greyAccent,
              ),
              const SizedBox(
                height: 25,
              ),
              ButtonComponent(
                  height: 50,
                  width: double.infinity,
                  colors: ColorPicker.primary,
                  button: TextButton(
                      onPressed: () {
                        profileController.updatePassword('farm');
                      },
                      child: const Text(
                        'Update',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: FontPicker.bold,
                            color: ColorPicker.white),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
