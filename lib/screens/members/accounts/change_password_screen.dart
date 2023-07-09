import 'package:gofarmin_app/controllers/profile_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/components/button_component.dart';
import 'package:gofarmin_app/screens/components/header_account_component.dart';
import 'package:gofarmin_app/screens/components/input_component.dart';
import 'package:gofarmin_app/screens/components/label_component.dart';
import 'package:gofarmin_app/screens/members/accounts/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeMemberPasswordScreen extends StatefulWidget {
  const ChangeMemberPasswordScreen({super.key});

  @override
  State<ChangeMemberPasswordScreen> createState() =>
      _ChangeMemberPasswordScreenState();
}

class _ChangeMemberPasswordScreenState
    extends State<ChangeMemberPasswordScreen> {
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
                  Get.off(const AccountMemberScreen());
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
                        profileController.updatePassword('member');
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
