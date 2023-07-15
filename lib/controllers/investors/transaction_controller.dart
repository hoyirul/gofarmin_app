import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gofarmin_app/models/transaction_model.dart';
import 'package:gofarmin_app/screens/investors/invests/payment_screen.dart';
import 'package:gofarmin_app/utils/alert_helpers.dart';
import 'package:gofarmin_app/utils/header_helpers.dart';
import 'package:gofarmin_app/utils/http_helpers.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionController extends GetxController {
  final isLoading = true.obs;
  TextEditingController qtyController = TextEditingController();
  final transactionList = <TransactionModel>[].obs;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);
      var data = await getList();
      if (data != null) {
        transactionList.assignAll(data);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<List<TransactionModel>?> getList() async {
    final prefs = await _prefs;
    try {
      var url = Uri.parse(HttpHelper().getUri('/transactions'));

      final response = await http.get(url,
          headers: HeaderHelper().headersLogged(
              prefs.getString('token_type'), prefs.getString('access_token')));

      if (response.statusCode == 200) {
        var decodeJson = json.decode(response.body)['data'];
        var jsonString = json.encode(decodeJson);
        return transactionModelFromJson(jsonString);
      }
    } catch (error) {
      Get.back();

      AlertHelper().showAlert(error.toString());
    }
    return null;
  }

  Future<void> addTransaction(goatId, price, type) async {
    final prefs = await _prefs;
    final url = Uri.parse(HttpHelper().getUri('/transactions'));
    Map body = {
      'goat_id': goatId,
      'qty': qtyController.text,
      'price': price,
      'type': type
    };

    if (qtyController.text == '') {
      AlertHelper().showAlert('Qty must be filled!');
    } else {
      try {
        final response = await http.post(url,
            body: jsonEncode(body),
            headers: HeaderHelper().headersLogged(prefs.getString('token_type'),
                prefs.getString('access_token')));
        if (response.statusCode == 200) {
          qtyController.clear();
          Get.to(const PaymentInvestorScreen(),
              transition: Transition.circularReveal);
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

  // Future<ShowMemberModel?> getById(id) async {
  //   final prefs = await _prefs;
  //   try {
  //     var url = Uri.parse(HttpHelper().getUri('/members/$id'));

  //     final response = await http.get(url,
  //         headers: HeaderHelper().headersLogged(
  //             prefs.getString('token_type'), prefs.getString('access_token')));

  //     if (response.statusCode == 200) {
  //       var decodeJson = json.decode(response.body)['data'];
  //       var jsonString = json.encode(decodeJson);
  //       return showMemberModelFromJson(jsonString);
  //     }
  //   } catch (error) {
  //     Get.back();

  //     AlertHelper().showAlert(error.toString());
  //   }
  //   return null;
  // }
}
