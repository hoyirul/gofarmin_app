import 'dart:io';
import 'package:gofarmin_app/controllers/members/goat_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/components/button_alert_component.dart';
import 'package:gofarmin_app/screens/components/button_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/components/confirm_dialog_component.dart';
import 'package:gofarmin_app/screens/components/input_component.dart';
import 'package:gofarmin_app/screens/components/label_component.dart';
import 'package:image_picker/image_picker.dart';

class EditGoatMemberScreen extends StatefulWidget {
  final int id;
  final int age, price;
  final String name, information;
  const EditGoatMemberScreen(
      {super.key,
      required this.id,
      required this.name,
      required this.age,
      required this.price,
      required this.information});

  @override
  State<EditGoatMemberScreen> createState() => _EditGoatMemberScreenState();
}

class _EditGoatMemberScreenState extends State<EditGoatMemberScreen> {
  GoatController goatController = Get.put(GoatController());

  @override
  void initState() {
    super.initState();

    // Gunakan widget.name untuk mengatur nilai GetX dan TextEditingController
    goatController.setName(widget.name);
    goatController.setAge(widget.age.toString());
    goatController.setPrice(widget.price.toString());
    goatController.setInformation(widget.information);

    // Panggil metode untuk mengatur nilai TextEditingController di luar dari initState()
    WidgetsBinding.instance.addPostFrameCallback((_) {
      goatController.updateTextEditingControllers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () => goatController.cancel(),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorPicker.grey.withOpacity(0.2),
                      ),
                      child: const Icon(
                        Icons.close,
                        color: ColorPicker.grey,
                      ),
                    ),
                  ),
                ),
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
                InputComponent(
                  textEditingController: goatController.nameController,
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
                  children: [
                    Expanded(
                      child: InputComponent(
                        textEditingController: goatController.ageController,
                        hintText: 'Age',
                        obscuredText: false,
                        colors: ColorPicker.greyAccent,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InputComponent(
                        textEditingController: goatController.priceController,
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
                InputComponent(
                  textEditingController: goatController.informationController,
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
                          child: Obx(() => goatController.selectedImage != null
                              ? Image.file(goatController.selectedImage!)
                              : const Text('No image selected')),
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
                              onTap: () async {
                                final pickedImage = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (pickedImage != null) {
                                  goatController
                                      .pickImage(File(pickedImage.path));
                                }
                                // For IOS
                                // final permissionStatus = await Permission.photos
                                //     .request(); // Request gallery access permission
                                // if (permissionStatus.isGranted) {
                                //   final pickedImage = await ImagePicker()
                                //       .pickImage(source: ImageSource.gallery);
                                //   if (pickedImage != null) {
                                //     transactionController
                                //         .pickImage(File(pickedImage.path));
                                //   }
                                // } else {
                                //   // Show a dialog or snackbar informing the user that the permission was not granted
                                //   Get.snackbar('Permission Denied',
                                //       'Please allow access to the gallery');
                                // }
                              },
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
                            )),
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
                              return ConfirmDialogComponent(
                                message: 'Are you sure?',
                                confirm: InkWell(
                                    onTap: () =>
                                        goatController.updateGoat(widget.id),
                                    child: const ButtonAlertComponent(
                                      text: 'Yes',
                                      colors: ColorPicker.primary,
                                    )),
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
                const SizedBox(
                  height: 10,
                ),
                ButtonComponent(
                    height: 50,
                    width: double.infinity,
                    colors: ColorPicker.danger,
                    button: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ConfirmDialogComponent(
                                message: 'Are you sure?',
                                confirm: InkWell(
                                    onTap: () =>
                                        goatController.destroyById(widget.id),
                                    child: const ButtonAlertComponent(
                                      text: 'Yes',
                                      colors: ColorPicker.primary,
                                    )),
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Delete',
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
