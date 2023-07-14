import 'dart:async';

import 'package:gofarmin_app/controllers/auth_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/agriculture_gov/home/home_screen.dart';
import 'package:gofarmin_app/screens/choices/choice_screen.dart';
import 'package:gofarmin_app/screens/farm_gov/home/home_screen.dart';
import 'package:gofarmin_app/screens/investors/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/members/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    redirectScreen();
  }

  void redirectScreen() async {
    final prefs = await _prefs;
    if (prefs.getString('access_token') == null) {
      Timer(const Duration(seconds: 3), () => Get.off(const ChoiceScreen()));
    } else {
      // AuthController authController = Get.put(AuthController());
      // authController.logout();
      switch (prefs.getInt('role_id')) {
        case 2:
          Timer(const Duration(seconds: 3),
              () => Get.off(const HomeInvestorScreen()));
          break;
        case 3:
          Timer(const Duration(seconds: 3),
              () => Get.off(const HomeMemberScreen()));
          break;
        case 4:
          Timer(const Duration(seconds: 3),
              () => Get.off(const HomeFarmGovScreen()));
          break;
        case 5:
          Timer(const Duration(seconds: 3),
              () => Get.off(const HomeAgricultureGovScreen()));
          break;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPicker.bg,
      body: Container(
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Center(child: Image.asset('assets/images/logo.png')),
            Container(
              padding: const EdgeInsets.only(bottom: 50),
              child: const Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'By MBIK Team',
                  style: TextStyle(
                      fontFamily: FontPicker.medium, color: ColorPicker.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
