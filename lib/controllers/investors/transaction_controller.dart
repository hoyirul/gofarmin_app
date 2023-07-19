import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gofarmin_app/models/transaction_by_invoice_model.dart';
import 'package:gofarmin_app/models/transaction_model.dart';
import 'package:gofarmin_app/screens/investors/invests/payment_screen.dart';
import 'package:gofarmin_app/screens/investors/transactions/transaction_screen.dart';
import 'package:gofarmin_app/utils/alert_helpers.dart';
import 'package:gofarmin_app/utils/header_helpers.dart';
import 'package:gofarmin_app/utils/http_helpers.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:random_string/random_string.dart';

class TransactionController extends GetxController {
  final isLoading = true.obs;
  final _selectedImage = Rx<File?>(null);
  File? get selectedImage => _selectedImage.value;
  TextEditingController qtyController = TextEditingController();
  final transactionList = <TransactionModel>[].obs;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void pickImage(File image) {
    _selectedImage.value = image;
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
    String invoice = 'INV-${randomNumeric(10)}';

    Map body = {
      'goat_id': goatId,
      'invoice': invoice,
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
          Get.to(PaymentInvestorScreen(invoice: invoice),
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

  Future<void> uploadImage(id) async {
    final prefs = await _prefs;
    if (selectedImage == null) {
      Get.snackbar('Error', 'Please select an image first');
      return;
    }

    // Ganti URL_API dengan URL API yang sesuai di server Anda
    final url = Uri.parse(HttpHelper().getUri('/transactions/payments/$id'));

    try {
      final request = http.MultipartRequest('POST', url);
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] =
          '${prefs.getString('token_type')} ${prefs.getString('access_token')}';
      request.files
          .add(await http.MultipartFile.fromPath('pop', selectedImage!.path));
      final response = await request.send();
      if (response.statusCode == 200) {
        Get.off(const TransactionInvestorScreen(),
            transition: Transition.circularReveal);
        Get.snackbar('Success', 'Image uploaded successfully');
        _selectedImage.value = null;
      } else {
        Get.snackbar('Error', 'Failed to upload image');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
    }
  }

  Future<TransactionByInvoiceModel?> showByInvoice(invoice) async {
    final prefs = await _prefs;
    try {
      var url =
          Uri.parse(HttpHelper().getUri('/transactions/$invoice/invoice'));

      final response = await http.get(url,
          headers: HeaderHelper().headersLogged(
              prefs.getString('token_type'), prefs.getString('access_token')));

      if (response.statusCode == 200) {
        var decodeJson = json.decode(response.body)['data'];
        var jsonString = json.encode(decodeJson);
        return transactionByInvoiceModelFromJson(jsonString);
      }
    } catch (error) {
      Get.back();

      AlertHelper().showAlert(error.toString());
    }
    return null;
  }

  Future<void> destroyById(id) async {
    final prefs = await _prefs;
    try {
      var url = Uri.parse(HttpHelper().getUri('/transactions/$id'));

      final response = await http.delete(url,
          headers: HeaderHelper().headersLogged(
              prefs.getString('token_type'), prefs.getString('access_token')));

      if (response.statusCode == 200) {
        Get.off(const TransactionInvestorScreen(),
            transition: Transition.circularReveal);
        Get.snackbar('Success', 'Transaction deleted successfully');
      }
    } catch (error) {
      Get.back();

      AlertHelper().showAlert(error.toString());
    }
  }
}
