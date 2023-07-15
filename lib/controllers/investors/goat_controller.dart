import 'dart:convert';

import 'package:gofarmin_app/models/goat_by_member.dart';
import 'package:gofarmin_app/models/show_goat_model.dart';
import 'package:gofarmin_app/utils/alert_helpers.dart';
import 'package:gofarmin_app/utils/header_helpers.dart';
import 'package:gofarmin_app/utils/http_helpers.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoatController extends GetxController {
  final isLoading = true.obs;
  RxString memberId = ''.obs;
  final goatByMemberList = <GoatByMemberModel>[].obs;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);
      var data = await showGoatByMember();
      if (data != null) {
        goatByMemberList.assignAll(data);
      }
    } finally {
      isLoading(false);
    }
  }

  void setMemberId(String id) {
    memberId.value = id;
  }

  Future<List<GoatByMemberModel>?> showGoatByMember() async {
    final prefs = await _prefs;
    try {
      var url = Uri.parse(HttpHelper().getUri('/members/$memberId/goats'));

      final response = await http.get(url,
          headers: HeaderHelper().headersLogged(
              prefs.getString('token_type'), prefs.getString('access_token')));

      if (response.statusCode == 200) {
        var decodeJson = json.decode(response.body)['data'];
        var jsonString = json.encode(decodeJson);
        return goatByMemberModelFromJson(jsonString);
      }
    } catch (error) {
      Get.back();

      AlertHelper().showAlert(error.toString());
    }
    return null;
  }

  Future<ShowGoatModel?> getById(id) async {
    final prefs = await _prefs;
    try {
      var url = Uri.parse(HttpHelper().getUri('/goats/$id'));

      final response = await http.get(url,
          headers: HeaderHelper().headersLogged(
              prefs.getString('token_type'), prefs.getString('access_token')));

      if (response.statusCode == 200) {
        var decodeJson = json.decode(response.body)['data'];
        var jsonString = json.encode(decodeJson);
        return showGoatModelFromJson(jsonString);
      }
    } catch (error) {
      Get.back();

      AlertHelper().showAlert(error.toString());
    }
    return null;
  }
}
