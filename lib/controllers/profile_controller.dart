import 'dart:convert';

import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
// import 'package:gofarmin_app/screens/investors/account/account_screen.dart';
// import 'package:gofarmin_app/screens/members/account/account_screen.dart';
// import 'package:gofarmin_app/screens/farm_gov/account/account_screen.dart';
// import 'package:gofarmin_app/screens/agriculture_gov/account/account_screen.dart';
import 'package:gofarmin_app/utils/header_helpers.dart';
import 'package:gofarmin_app/utils/http_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getEditingController();
  }

  void getEditingController() async {
    final prefs = await _prefs;
    nameController.text = prefs.getString('name')!;
    addressController.text = prefs.getString('address')!;
  }

  Future<int?> getId() async {
    final prefs = await _prefs;
    return prefs.getInt('id');
  }

  Future<int?> getUserRoleId() async {
    final prefs = await _prefs;
    return prefs.getInt('user_role_id');
  }

  Future<String?> getAccessToken() async {
    final prefs = await _prefs;
    return prefs.getString('access_token');
  }

  Future<String?> getTokenType() async {
    final prefs = await _prefs;
    return prefs.getString('token_type');
  }

  Future<String?> getName() async {
    final prefs = await _prefs;
    return prefs.getString('name');
  }

  Future<String?> getEmail() async {
    final prefs = await _prefs;
    return prefs.getString('email');
  }

  Future<int?> getRoleId() async {
    final prefs = await _prefs;
    return prefs.getInt('role_id');
  }

  Future<String?> getAddress() async {
    final prefs = await _prefs;
    return prefs.getString('address');
  }

  Future<String?> getMemberStatus() async {
    final prefs = await _prefs;
    return prefs.getString('member_status');
  }

  Future<String?> getGovNumber() async {
    final prefs = await _prefs;
    return prefs.getString('gov_number');
  }

  void showAlert(title, error, Color colors) {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              title,
              style: TextStyle(color: colors, fontFamily: FontPicker.medium),
            ),
            contentPadding: const EdgeInsets.all(20),
            children: [Text(error)],
          );
        });
  }

  Future<void> updateProfile(role) async {
    final prefs = await _prefs;
    final id = prefs.getInt('id');

    final url = Uri.parse(HttpHelper().getUri('/settings/profile/$id'));
    Map body = {'name': nameController.text, 'address': addressController.text};

    try {
      final response = await http.put(url,
          body: jsonEncode(body),
          headers: HeaderHelper().headersLogged(
              prefs.getString('token_type'), prefs.getString('access_token')));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body)['data'];
        prefs.setString('name', json['name']);
        prefs.setString('address', json['address']);

        switch (role) {
          case 'investor':
            // Get.off(const AccountInvestorScreen());
            print('Investor');
            break;
          case 'member':
            // Get.off(const AccountMemberScreen());
            print('Member');
            break;
          case 'farm':
            // Get.off(const AccountFarmGovScreen());
            print('Farm');
            break;
          case 'agriculture':
            // Get.off(const AccountAgricultureGovScreen());
            print('Agriculture');
            break;
        }

        showAlert(
            'Success', 'Your profile has been updated!', ColorPicker.green);
      } else if (response.statusCode == 422) {
        var data = jsonDecode(response.body)["data"];
        throw (data["name"] != null) ? data["name"] : data["address"];
      } else {
        throw jsonDecode(response.body)["errors"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      showAlert('Error', error.toString(), ColorPicker.danger);
    }
  }

  Future<void> updatePassword(role) async {
    final prefs = await _prefs;
    final id = prefs.getInt('id');

    final url = Uri.parse(HttpHelper().getUri('/settings/password/$id'));
    Map body = {
      'old_password': oldPasswordController.text,
      'password': passwordController.text,
      'password_confirmation': passwordConfirmationController.text
    };

    try {
      final response = await http.put(url,
          body: jsonEncode(body),
          headers: HeaderHelper().headersLogged(
              prefs.getString('token_type'), prefs.getString('access_token')));
      if (response.statusCode == 200) {
        oldPasswordController.clear();
        passwordController.clear();
        passwordConfirmationController.clear();

        switch (role) {
          case 'investor':
            // Get.off(const AccountInvestorScreen());
            print('Investor');
            break;
          case 'member':
            // Get.off(const AccountMemberScreen());
            print('Member');
            break;
          case 'farm':
            // Get.off(const AccountFarmGovScreen());
            print('Farm');
            break;
          case 'agriculture':
            // Get.off(const AccountAgricultureGovScreen());
            print('Agriculture');
            break;
        }

        showAlert(
            'Success', 'Your password has been updated!', ColorPicker.green);
      } else if (response.statusCode == 400) {
        throw jsonDecode(response.body)["errors"] ?? "Unknown Error Occured";
      } else if (response.statusCode == 422) {
        var data = jsonDecode(response.body)["data"];
        throw (data["password"] != null)
            ? data["password"]
            : data["password_confirmation"];
      } else {
        throw jsonDecode(response.body)["errors"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      showAlert('Error', error.toString(), ColorPicker.danger);
    }
  }
}
