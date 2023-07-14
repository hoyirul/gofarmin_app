import 'package:gofarmin_app/controllers/auth_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/components/alert_dialog_component.dart';
import 'package:gofarmin_app/screens/components/button_component.dart';
import 'package:gofarmin_app/screens/components/header_account_component.dart';
import 'package:gofarmin_app/screens/components/setting_component.dart';
import 'package:gofarmin_app/screens/agriculture_gov/accounts/change_password_screen.dart';
import 'package:gofarmin_app/screens/agriculture_gov/accounts/change_profile_screen.dart';
import 'package:gofarmin_app/screens/agriculture_gov/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountAgricultureGovScreen extends StatefulWidget {
  const AccountAgricultureGovScreen({super.key});

  @override
  State<AccountAgricultureGovScreen> createState() =>
      _AccountAgricultureGovScreenState();
}

class _AccountAgricultureGovScreenState
    extends State<AccountAgricultureGovScreen> {
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 25, top: 50, bottom: 50),
          child: Column(
            children: [
              HeaderAccountComponent(
                  inkWell: InkWell(
                onTap: () {
                  Get.off(const HomeAgricultureGovScreen());
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
                  'Settings',
                  style: TextStyle(
                      fontFamily: FontPicker.semibold,
                      fontSize: 18,
                      color: ColorPicker.dark),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Get.off(const ChangeAgricultureGovProfileScreen());
                },
                child: const SettingComponentFeatures(
                  title: 'Change Profile',
                  icon: Icon(
                    Icons.account_circle_rounded,
                    color: ColorPicker.primary,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.off(const ChangeAgricultureGovPasswordScreen());
                },
                child: const SettingComponentFeatures(
                  title: 'Change Password',
                  icon: Icon(
                    Icons.security_rounded,
                    color: ColorPicker.primary,
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialogComponent(
                          message:
                              'What should we do (Whatsapp : +628574635637) ?');
                    },
                  );
                },
                child: const SettingComponentFeatures(
                  title: 'Help',
                  icon: Icon(
                    Icons.help_rounded,
                    color: ColorPicker.primary,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ButtonComponent(
                  button: TextButton(
                    onPressed: () {
                      authController.logout();
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                          color: ColorPicker.white,
                          fontFamily: FontPicker.semibold,
                          fontSize: 16),
                    ),
                  ),
                  colors: ColorPicker.primary,
                  height: 60,
                  width: double.infinity)
            ],
          ),
        ),
      ),
    );
  }
}
