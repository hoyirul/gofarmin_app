import 'package:gofarmin_app/controllers/auth_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/choices/choice_screen.dart';
import 'package:gofarmin_app/screens/agriculture_gov/auth/register_screen.dart';
import 'package:gofarmin_app/screens/components/button_component.dart';
import 'package:gofarmin_app/screens/components/input_component.dart';
import 'package:gofarmin_app/screens/components/label_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginAgricultureGovScreen extends StatefulWidget {
  const LoginAgricultureGovScreen({super.key});

  @override
  State<LoginAgricultureGovScreen> createState() =>
      _LoginAgricultureGovScreenState();
}

class _LoginAgricultureGovScreenState extends State<LoginAgricultureGovScreen> {
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, left: 35, right: 35, bottom: 50),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.off(const ChoiceScreen());
                },
                child: Row(
                  children: const [
                    Icon(Icons.arrow_back_ios),
                    Text('Back'),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 25, left: 30, right: 30, bottom: 10),
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.transparent),
                child: Image.asset('assets/images/logo.png'),
              ),
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Let`s you sign in',
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
                height: 20,
              ),
              const LabelComponent(label: 'Email : '),
              InputComponent(
                textEditingController: authController.emailController,
                hintText: 'Enter your email',
                obscuredText: false,
                colors: ColorPicker.greyAccent,
              ),
              const SizedBox(
                height: 15,
              ),
              const LabelComponent(label: 'Password : '),
              InputComponent(
                textEditingController: authController.passwordController,
                hintText: 'Enter your password',
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
                        authController.authLogin('agriculture');
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: FontPicker.bold,
                            color: ColorPicker.white),
                      ))),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don`t have account? ',
                    style: TextStyle(fontFamily: FontPicker.regular),
                  ),
                  InkWell(
                    onTap: () {
                      Get.offAll(const RegisterAgricultureGovScreen());
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                          color: ColorPicker.primary,
                          fontFamily: FontPicker.regular),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
