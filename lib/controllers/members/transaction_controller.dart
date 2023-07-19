import 'dart:convert';

import 'package:gofarmin_app/models/transaction_by_invoice_model.dart';
import 'package:gofarmin_app/models/transaction_by_member_model.dart';
import 'package:gofarmin_app/utils/alert_helpers.dart';
import 'package:gofarmin_app/utils/header_helpers.dart';
import 'package:gofarmin_app/utils/http_helpers.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionController extends GetxController {
  final isLoading = true.obs;
  final transactionList = <TransactionByMemberModel>[].obs;
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

  Future<List<TransactionByMemberModel>?> getList() async {
    final prefs = await _prefs;
    try {
      var url = Uri.parse(HttpHelper().getUri('/transactions/show/members'));

      final response = await http.get(url,
          headers: HeaderHelper().headersLogged(
              prefs.getString('token_type'), prefs.getString('access_token')));

      if (response.statusCode == 200) {
        var decodeJson = json.decode(response.body)['data'];
        var jsonString = json.encode(decodeJson);
        return transactionByMemberModelFromJson(jsonString);
      }
    } catch (error) {
      Get.back();

      AlertHelper().showAlert(error.toString());
    }
    return null;
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
}
