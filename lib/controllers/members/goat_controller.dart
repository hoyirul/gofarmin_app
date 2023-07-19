import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gofarmin_app/models/goat_by_member_model.dart';
import 'package:gofarmin_app/models/show_goat_model.dart';
import 'package:gofarmin_app/screens/members/goats/goat_list_screen.dart';
import 'package:gofarmin_app/utils/alert_helpers.dart';
import 'package:gofarmin_app/utils/header_helpers.dart';
import 'package:gofarmin_app/utils/http_helpers.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoatController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController informationController = TextEditingController();
  RxString name = RxString('');
  RxString age = RxString('');
  RxString price = RxString('');
  RxString information = RxString('');

  final isLoading = true.obs;
  RxString memberId = ''.obs;
  final _selectedImage = Rx<File?>(null);
  File? get selectedImage => _selectedImage.value;
  final goatByMemberList = <GoatByMemberModel>[].obs;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    ageController.dispose();
    priceController.dispose();
    super.onClose();
  }

  void pickImage(File image) {
    _selectedImage.value = image;
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

  // Metode untuk mengubah nilai name, age, dan price
  void setName(String value) => name.value = value;
  void setAge(String value) => age.value = value;
  void setPrice(String value) => price.value = value;
  void setInformation(String value) => information.value = value;

  void setMemberId(String id) {
    memberId.value = id;
  }

  void updateTextEditingControllers() {
    nameController.text = name.value;
    ageController.text = age.value;
    priceController.text = price.value;
    informationController.text = information.value;
  }

  void cancel() {
    Get.to(const GoatListMemberScreen(), transition: Transition.leftToRight);
    nameController.clear();
    ageController.clear();
    priceController.clear();
    informationController.clear();
    _selectedImage.value = null;
  }

  Future<void> storeGoat() async {
    final prefs = await _prefs;
    if (selectedImage == null) {
      Get.snackbar('Error', 'Please select an image first');
      return;
    }

    // Ganti URL_API dengan URL API yang sesuai di server Anda
    final url = Uri.parse(HttpHelper().getUri('/goats'));

    try {
      String name = nameController.text.trim();
      String age = ageController.text;
      String price = priceController.text;
      String information = informationController.text.trim();

      final request = http.MultipartRequest('POST', url);
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] =
          '${prefs.getString('token_type')} ${prefs.getString('access_token')}';
      request.fields['goat_name'] = name;
      request.fields['age'] = age;
      request.fields['price'] = price;
      request.fields['information'] = information;
      request.files
          .add(await http.MultipartFile.fromPath('image', selectedImage!.path));

      final response = await request.send();
      if (response.statusCode == 200) {
        Get.off(const GoatListMemberScreen(),
            transition: Transition.circularReveal);
        fetchData();
        Get.snackbar('Success', 'Data stored successfully');
        nameController.clear();
        ageController.clear();
        priceController.clear();
        informationController.clear();
        _selectedImage.value = null;
      } else {
        Get.snackbar('Error', 'Failed to store data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
    }
  }

  Future<void> updateGoat(id) async {
    final prefs = await _prefs;
    if (selectedImage == null) {
      Get.snackbar('Error', 'Please select an image first');
      return;
    }

    // Ganti URL_API dengan URL API yang sesuai di server Anda
    final url = Uri.parse(HttpHelper().getUri('/goats/$id'));

    try {
      String name = nameController.text.trim();
      String age = ageController.text;
      String price = priceController.text;
      String information = informationController.text.trim();

      final request = http.MultipartRequest('POST', url);
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] =
          '${prefs.getString('token_type')} ${prefs.getString('access_token')}';
      request.fields['goat_name'] = name;
      request.fields['age'] = age;
      request.fields['price'] = price;
      request.fields['information'] = information;
      request.files
          .add(await http.MultipartFile.fromPath('image', selectedImage!.path));

      final response = await request.send();
      if (response.statusCode == 200) {
        Get.off(const GoatListMemberScreen(),
            transition: Transition.circularReveal);
        fetchData();
        Get.snackbar('Success', 'Data stored successfully');
        nameController.clear();
        ageController.clear();
        priceController.clear();
        informationController.clear();
        _selectedImage.value = null;
      } else {
        Get.snackbar('Error', 'Failed to store data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
    }
  }

  Future<void> destroyById(id) async {
    final prefs = await _prefs;
    try {
      var url = Uri.parse(HttpHelper().getUri('/goats/$id'));

      final response = await http.delete(url,
          headers: HeaderHelper().headersLogged(
              prefs.getString('token_type'), prefs.getString('access_token')));

      if (response.statusCode == 200) {
        Get.off(const GoatListMemberScreen(),
            transition: Transition.circularReveal);
        fetchData();
        Get.snackbar('Success', 'Data deleted successfully');
      }
    } catch (error) {
      Get.back();

      AlertHelper().showAlert(error.toString());
    }
  }

  Future<List<GoatByMemberModel>?> showGoatByMember() async {
    final prefs = await _prefs;
    try {
      var url = Uri.parse(HttpHelper().getUri('/goats'));

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
