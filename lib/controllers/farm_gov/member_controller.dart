import 'dart:convert';

import 'package:gofarmin_app/models/member_model.dart';
import 'package:gofarmin_app/models/show_member_model.dart';
import 'package:gofarmin_app/utils/alert_helpers.dart';
import 'package:gofarmin_app/utils/header_helpers.dart';
import 'package:gofarmin_app/utils/http_helpers.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberController extends GetxController {
  final isLoading = true.obs;
  final memberList = <MemberModel>[].obs;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);
      var members = await getList();
      if (members != null) {
        memberList.assignAll(members);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<List<MemberModel>?> getList() async {
    final prefs = await _prefs;
    try {
      var url = Uri.parse(HttpHelper().getUri('/members/by/gov'));

      final response = await http.get(url,
          headers: HeaderHelper().headersLogged(
              prefs.getString('token_type'), prefs.getString('access_token')));

      if (response.statusCode == 200) {
        var decodeJson = json.decode(response.body)['data'];
        var jsonString = json.encode(decodeJson);
        return memberModelFromJson(jsonString);
      }
    } catch (error) {
      Get.back();

      AlertHelper().showAlert(error.toString());
    }
    return null;
  }

  Future<ShowMemberModel?> getById(id) async {
    final prefs = await _prefs;
    try {
      var url = Uri.parse(HttpHelper().getUri('/members/$id'));

      final response = await http.get(url,
          headers: HeaderHelper().headersLogged(
              prefs.getString('token_type'), prefs.getString('access_token')));

      if (response.statusCode == 200) {
        var decodeJson = json.decode(response.body)['data'];
        var jsonString = json.encode(decodeJson);
        return showMemberModelFromJson(jsonString);
      }
    } catch (error) {
      Get.back();

      AlertHelper().showAlert(error.toString());
    }
    return null;
  }
}
