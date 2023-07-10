import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/components/button_component.dart';
import 'package:gofarmin_app/screens/farm_gov/auth/login_screen.dart';
import 'package:gofarmin_app/screens/investors/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/members/auth/login_screen.dart';

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, left: 50, right: 50, bottom: 50),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 25, left: 0, right: 0, bottom: 10),
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.transparent),
                child: Image.asset('assets/images/logo.png'),
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose your account',
                  style: TextStyle(
                      color: ColorPicker.dark,
                      fontFamily: FontPicker.bold,
                      fontSize: 25),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome back you have been missed.',
                  style: TextStyle(
                      color: ColorPicker.grey,
                      fontFamily: FontPicker.regular,
                      fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ButtonComponent(
                  height: 50,
                  width: double.infinity,
                  colors: ColorPicker.white,
                  button: TextButton(
                      onPressed: () {
                        Get.offAll(const LoginInvestorScreen());
                      },
                      child: const Text(
                        'Investor',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: FontPicker.semibold,
                            color: ColorPicker.primary),
                      ))),
              const SizedBox(
                height: 15,
              ),
              ButtonComponent(
                  height: 50,
                  width: double.infinity,
                  colors: ColorPicker.white,
                  button: TextButton(
                      onPressed: () {
                        Get.offAll(const LoginMemberScreen());
                      },
                      child: const Text(
                        'Member',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: FontPicker.semibold,
                            color: ColorPicker.primary),
                      ))),
              const SizedBox(
                height: 15,
              ),
              ButtonComponent(
                  height: 50,
                  width: double.infinity,
                  colors: ColorPicker.white,
                  button: TextButton(
                      onPressed: () {
                        Get.offAll(const LoginFarmGovScreen());
                      },
                      child: const Text(
                        'Dinas Peternakan',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: FontPicker.semibold,
                            color: ColorPicker.primary),
                      ))),
              const SizedBox(
                height: 15,
              ),
              ButtonComponent(
                  height: 50,
                  width: double.infinity,
                  colors: ColorPicker.white,
                  button: TextButton(
                      onPressed: () {
                        // Get.offAll(const LoginAgricultureGovScreen());
                        print('Oke');
                      },
                      child: const Text(
                        'Dinas Ketahanan Pangan',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: FontPicker.semibold,
                            color: ColorPicker.primary),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
