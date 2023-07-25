import 'dart:convert';
import 'package:gofarmin_app/screens/agriculture_gov/auth/login_screen.dart';
import 'package:gofarmin_app/screens/agriculture_gov/home/home_screen.dart';
import 'package:gofarmin_app/screens/choices/choice_screen.dart';
import 'package:gofarmin_app/screens/components/alert_dialog_component.dart';
import 'package:gofarmin_app/screens/farm_gov/auth/login_screen.dart';
import 'package:gofarmin_app/screens/farm_gov/home/home_screen.dart';
import 'package:gofarmin_app/screens/investors/auth/login_screen.dart';
import 'package:gofarmin_app/screens/investors/home/home_screen.dart';
import 'package:gofarmin_app/screens/members/auth/login_screen.dart';
import 'package:gofarmin_app/screens/members/home/home_screen.dart';
import 'package:gofarmin_app/utils/alert_helpers.dart';
import 'package:gofarmin_app/utils/header_helpers.dart';
import 'package:gofarmin_app/utils/http_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfimationController = TextEditingController();

  final Future<SharedPreferences> preferences = SharedPreferences.getInstance();

  void showAlert(message) {
    Get.back();
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialogComponent(message: message);
        });
  }

  Future<void> authLogin(String role) async {
    final url = Uri.parse(HttpHelper().getUri('/auth/login/$role'));
    Map body = {
      'email': emailController.text.trim(),
      'password': passwordController.text
    };

    if (emailController.text == '' || passwordController.text == '') {
      AlertHelper().showAlert('Email or Password must be filled!');
    } else {
      try {
        final response = await http.post(url,
            body: jsonEncode(body), headers: HeaderHelper().headersUnlogged());
        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);
          final SharedPreferences prefs = await preferences;
          emailController.clear();
          passwordController.clear();
          prefs.setInt('id', json['data']['user']['id']);
          prefs.setString('access_token', json['data']['access_token']);
          prefs.setString('token_type', json['data']['token_type']);
          prefs.setString('email', json['data']['user']['email']);
          prefs.setInt('role_id', json['data']['user']['role_id']);

          switch (role) {
            case 'investor':
              prefs.setInt(
                  'user_role_id', json['data']['user']['investor']['id']);
              prefs.setString('name', json['data']['user']['investor']['name']);
              prefs.setString(
                  'address', json['data']['user']['investor']['address'] ?? '');
              prefs.setString('member_status', '');
              prefs.setString('gov_number', 'none');
              Get.off(const HomeInvestorScreen());
              break;
            case 'member':
              switch (json['data']['user']['member']['member_status']) {
                case 'not-worthy':
                  AlertHelper().showAlert(
                      'Your account is still in the checking process!');
                  await http.post(url,
                      headers: HeaderHelper().headersLogged(
                          prefs.getString('token_type'),
                          prefs.getString('access_token')));
                  prefs.clear();
                  Get.off(const LoginMemberScreen());
                  break;
                default:
                  prefs.setInt(
                      'user_role_id', json['data']['user']['member']['id']);
                  prefs.setString(
                      'name', json['data']['user']['member']['name']);
                  prefs.setString('address',
                      json['data']['user']['member']['address'] ?? '');
                  prefs.setString('member_status',
                      json['data']['user']['member']['member_status']);
                  prefs.setString('gov_number', 'none');
                  Get.off(const HomeMemberScreen());
              }
              break;
            case 'farm':
              prefs.setInt(
                  'user_role_id', json['data']['user']['government']['id']);
              prefs.setString(
                  'name', json['data']['user']['government']['name']);
              prefs.setString('address',
                  json['data']['user']['government']['address'] ?? '');
              prefs.setString('member_status', '');
              prefs.setString('gov_number',
                  json['data']['user']['government']['gov_number'] ?? '');
              Get.off(const HomeFarmGovScreen());
              break;
            case 'agriculture':
              prefs.setInt(
                  'user_role_id', json['data']['user']['government']['id']);
              prefs.setString(
                  'name', json['data']['user']['government']['name']);
              prefs.setString('address',
                  json['data']['user']['government']['address'] ?? '');
              prefs.setString('member_status', '');
              prefs.setString('gov_number',
                  json['data']['user']['government']['gov_number'] ?? '');
              Get.off(const HomeAgricultureGovScreen());
              break;
          }
        } else if (response.statusCode == 400) {
          throw jsonDecode(response.body)["errors"] ?? "Unknown Error Occured";
        } else {
          throw jsonDecode(response.body)["errors"] ?? "Unknown Error Occured";
        }
      } catch (error) {
        AlertHelper().showAlert(error.toString());
      }
    }
  }

  Future<void> authRegister(String role) async {
    final url = Uri.parse(HttpHelper().getUri('/auth/register/$role'));
    Map body = {
      'name': nameController.text,
      'email': emailController.text.trim(),
      'password': passwordController.text
    };

    if (emailController.text == '' ||
        passwordController.text == '' ||
        passwordController.text == '' ||
        passwordConfimationController.text == '') {
      AlertHelper().showAlert(
          'Name, Email, Password and Confirm Password must be filled!');
    } else {
      if (passwordConfimationController.text != passwordController.text) {
        AlertHelper().showAlert('Your password confirmation doesn`t match!');
      } else {
        try {
          final response = await http.post(url,
              body: jsonEncode(body),
              headers: HeaderHelper().headersUnlogged());
          if (response.statusCode == 200) {
            nameController.clear();
            emailController.clear();
            passwordController.clear();
            passwordConfimationController.clear();
            switch (role) {
              case 'investor':
                Get.off(const LoginInvestorScreen());
                break;
              case 'member':
                Get.off(const LoginMemberScreen());
                break;
              case 'farm':
                Get.off(const LoginFarmGovScreen());
                break;
              case 'agriculture':
                Get.off(const LoginAgricultureGovScreen());
                break;
            }
            AlertHelper().showAlert(
                'your account has been registered and please login!');
          } else if (response.statusCode == 400) {
            throw jsonDecode(response.body)["errors"] ??
                "Unknown Error Occured";
          } else if (response.statusCode == 422) {
            throw jsonDecode(response.body)["data"] ?? "Unknown Error Occured";
          } else {
            throw jsonDecode(response.body)["errors"] ??
                "Unknown Error Occured";
          }
        } catch (error) {
          AlertHelper().showAlert(error.toString());
        }
      }
    }
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await preferences;
    final url = Uri.parse(HttpHelper().getUri('/auth/logout'));
    try {
      final response = await http.post(url,
          headers: HeaderHelper().headersLogged(
              prefs.getString('token_type'), prefs.getString('access_token')));
      if (response.statusCode == 200) {
        prefs.clear();
        Get.off(const ChoiceScreen());
      } else {
        throw jsonDecode(response.body)["errors"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      AlertHelper().showAlert(error.toString());
    }
  }
}
