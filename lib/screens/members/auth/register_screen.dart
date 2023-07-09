import 'package:gofarmin_app/controllers/auth_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/members/auth/login_screen.dart';
import 'package:gofarmin_app/screens/components/button_component.dart';
import 'package:gofarmin_app/screens/components/input_component.dart';
import 'package:gofarmin_app/screens/components/label_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterMemberScreen extends StatefulWidget {
  const RegisterMemberScreen({super.key});

  @override
  State<RegisterMemberScreen> createState() => _RegisterMemberScreenState();
}

class _RegisterMemberScreenState extends State<RegisterMemberScreen> {
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, left: 35, right: 35, bottom: 50),
          child: Column(
            children: [
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
                height: 25,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome !',
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
                  'And enjoy life during the time.',
                  style: TextStyle(
                      color: ColorPicker.grey,
                      fontFamily: FontPicker.regular,
                      fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const LabelComponent(label: 'Name : '),
              InputComponent(
                textEditingController: authController.nameController,
                hintText: 'Enter your name',
                obscuredText: false,
                colors: ColorPicker.greyAccent,
              ),
              const SizedBox(
                height: 15,
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
                height: 15,
              ),
              const LabelComponent(label: 'Confirm Password : '),
              InputComponent(
                textEditingController:
                    authController.passwordConfimationController,
                hintText: 'Confirm your password',
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
                      onPressed: () => authController.authRegister('member'),
                      child: const Text(
                        'Sign up',
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
                    'Already have account? ',
                    style: TextStyle(fontFamily: FontPicker.regular),
                  ),
                  InkWell(
                    onTap: () {
                      Get.offAll(const LoginMemberScreen());
                    },
                    child: const Text(
                      'Sign in',
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
