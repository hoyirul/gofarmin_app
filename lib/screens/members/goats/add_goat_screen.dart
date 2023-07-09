import 'package:file_picker/file_picker.dart';
import 'package:gofarmin_app/controllers/auth_controller.dart';
import 'package:gofarmin_app/controllers/profile_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/components/button_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/components/input_component.dart';
import 'package:gofarmin_app/screens/components/label_component.dart';
import 'package:gofarmin_app/screens/members/goats/goat_list_screen.dart';

class AddGoatMemberScreen extends StatefulWidget {
  const AddGoatMemberScreen({super.key});

  @override
  State<AddGoatMemberScreen> createState() => _AddGoatMemberScreenState();
}

class _AddGoatMemberScreenState extends State<AddGoatMemberScreen> {
  AuthController authController = Get.put(AuthController());
  ProfileController profileController = Get.put(ProfileController());
  var fileName = '';
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;

      // Lakukan sesuatu dengan file yang dipilih
      fileName = file.name;
      // print(file.name);
      // print(file.path);
    } else {
      // Pengguna tidak memilih file
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(const GoatListMemberScreen(),
                transition: Transition.circularReveal);
          },
          backgroundColor: ColorPicker.danger,
          child: const Icon(Icons.arrow_back),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Add Goat',
                          style: TextStyle(
                              fontFamily: FontPicker.bold,
                              color: ColorPicker.dark,
                              fontSize: 26),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const LabelComponent(label: 'Goat Type'),
                    const SizedBox(
                      height: 5,
                    ),
                    const InputComponent(
                      textEditingController: null,
                      hintText: 'Goat Name',
                      obscuredText: false,
                      colors: ColorPicker.greyAccent,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const LabelComponent(label: 'Age | Price'),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: const [
                        Expanded(
                          child: InputComponent(
                            textEditingController: null,
                            hintText: 'Age',
                            obscuredText: false,
                            colors: ColorPicker.greyAccent,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: InputComponent(
                            textEditingController: null,
                            hintText: 'Price',
                            obscuredText: false,
                            colors: ColorPicker.greyAccent,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const LabelComponent(label: 'Description'),
                    const SizedBox(
                      height: 5,
                    ),
                    const InputComponent(
                      textEditingController: null,
                      hintText: 'Description',
                      obscuredText: false,
                      colors: ColorPicker.greyAccent,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const LabelComponent(label: 'Goat Image'),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      padding: const EdgeInsets.only(left: 30, right: 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: ColorPicker.greyAccent,
                          boxShadow: const [
                            BoxShadow(
                                color: ColorPicker.greyLight,
                                offset: Offset(0, 1),
                                blurRadius: 0.3)
                          ]),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                fileName,
                                style: const TextStyle(
                                    color: ColorPicker.dark,
                                    fontFamily: FontPicker.regular,
                                    fontSize: 11),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(right: 30),
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      bottomRight: Radius.circular(25)),
                                  color: ColorPicker.greyLight,
                                  boxShadow: [
                                    BoxShadow(
                                        color: ColorPicker.greyLight,
                                        offset: Offset(0, 1),
                                        blurRadius: 0.3)
                                  ]),
                              child: InkWell(
                                onTap: () => pickFile(),
                                child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'File',
                                    style: TextStyle(
                                        fontFamily: FontPicker.semibold,
                                        color: ColorPicker.dark,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonComponent(
                        height: 50,
                        width: double.infinity,
                        colors: ColorPicker.primary,
                        button: TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Center(
                                        child: Text(
                                      'Are you sure?',
                                      style: TextStyle(
                                          fontFamily: FontPicker.medium,
                                          color: ColorPicker.dark,
                                          fontSize: 16),
                                    )),
                                    actions: [
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          print('oke');
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: FontPicker.bold,
                                  color: ColorPicker.white),
                            ))),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
