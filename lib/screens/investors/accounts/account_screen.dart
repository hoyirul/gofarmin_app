import 'package:gofarmin_app/controllers/auth_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/components/button_component.dart';
import 'package:gofarmin_app/screens/components/header_account_component.dart';
import 'package:gofarmin_app/screens/components/setting_component.dart';
import 'package:gofarmin_app/screens/investors/accounts/change_password_screen.dart';
import 'package:gofarmin_app/screens/investors/accounts/change_profile_screen.dart';
import 'package:gofarmin_app/screens/investors/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountInvestorScreen extends StatefulWidget {
  const AccountInvestorScreen({super.key});

  @override
  State<AccountInvestorScreen> createState() => _AccountInvestorScreenState();
}

class _AccountInvestorScreenState extends State<AccountInvestorScreen> {
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
                  Get.off(const HomeInvestorScreen());
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
                  Get.off(const ChangeInvestorProfileScreen());
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
                  Get.off(const ChangeInvestorPasswordScreen());
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
                      return const SimpleDialog(
                        alignment: Alignment.center,
                        title: Text(
                          'Information',
                          style: TextStyle(
                              color: ColorPicker.green,
                              fontFamily: FontPicker.medium),
                        ),
                        contentPadding: EdgeInsets.all(20),
                        children: [
                          Text('You can chat me on Whatsapp : +628574577438')
                        ],
                      );
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
