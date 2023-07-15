import 'package:file_picker/file_picker.dart';
import 'package:gofarmin_app/controllers/auth_controller.dart';
import 'package:gofarmin_app/controllers/profile_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/components/button_alert_component.dart';
import 'package:gofarmin_app/screens/components/button_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/components/confirm_dialog_component.dart';
import 'package:gofarmin_app/screens/components/label_component.dart';
import 'package:gofarmin_app/screens/investors/invests/detail_member_screen.dart';
import 'package:gofarmin_app/utils/http_helpers.dart';

class PaymentInvestorScreen extends StatefulWidget {
  const PaymentInvestorScreen({super.key});

  @override
  State<PaymentInvestorScreen> createState() => _PaymentInvestorScreenState();
}

class _PaymentInvestorScreenState extends State<PaymentInvestorScreen> {
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
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(0),
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(50)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                  child: Image.network(
                    '${HttpHelper().url}/images/members/member3.jpg',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Positioned(
                top: 50,
                right: 25,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmDialogComponent(
                          message: 'Are you sure to cancel this transaction?',
                          confirm: InkWell(
                              onTap: () => print('oke'),
                              // onTap: () => Get.to(
                              //     const DetailMemberInvestorScreen(),
                              //     transition: Transition.circularReveal),
                              child: const ButtonAlertComponent(
                                text: 'Yes',
                                colors: ColorPicker.primary,
                              )),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorPicker.white.withOpacity(0.4),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: ColorPicker.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'kambing Kacang',
                      style: TextStyle(
                          fontFamily: FontPicker.bold,
                          color: ColorPicker.dark,
                          fontSize: 22),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: const TextSpan(children: [
                              TextSpan(
                                  text: '1,299K',
                                  style: TextStyle(
                                      fontFamily: FontPicker.bold,
                                      color: ColorPicker.primary,
                                      fontSize: 30)),
                              TextSpan(
                                  text: ' / item',
                                  style: TextStyle(
                                      fontFamily: FontPicker.medium,
                                      color: ColorPicker.danger,
                                      fontSize: 16)),
                            ]),
                          )),
                    ),
                    const Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Age <> 3 months',
                          style: TextStyle(
                              color: ColorPicker.grey,
                              fontFamily: FontPicker.medium,
                              fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Lorem ipsum, atau ringkasnya lipsum, adalah teks standar yang ditempatkan untuk mendemostrasikan elemen grafis atau presentasi visual seperti font, tipografi, dan tata letak',
                      style: TextStyle(
                          fontFamily: FontPicker.regular,
                          color: ColorPicker.grey,
                          fontSize: 12),
                    )),
                const SizedBox(
                  height: 20,
                ),
                const LabelComponent(label: 'Invoice Code'),
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
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'INV-128293723',
                      style: TextStyle(
                          color: ColorPicker.dark,
                          fontFamily: FontPicker.medium,
                          fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const LabelComponent(label: 'Qty of Goats | Price'),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
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
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '5 Goats',
                            style: TextStyle(
                                color: ColorPicker.dark,
                                fontFamily: FontPicker.medium,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
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
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '1,299,000',
                            style: TextStyle(
                                color: ColorPicker.dark,
                                fontFamily: FontPicker.medium,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const LabelComponent(label: 'Payment Total'),
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
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '6,495,000',
                      style: TextStyle(
                          color: ColorPicker.dark,
                          fontFamily: FontPicker.medium,
                          fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Proof of Payment',
                      style: TextStyle(fontFamily: FontPicker.medium),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: ColorPicker.white),
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Transfer to',
                                      style: TextStyle(
                                        fontFamily: FontPicker.medium,
                                        color: ColorPicker.dark,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    DataTable(
                                      columns: const [
                                        DataColumn(label: Text('Bank')),
                                        DataColumn(label: Text('Number')),
                                      ],
                                      rows: const [
                                        DataRow(cells: [
                                          DataCell(Text('BCA')),
                                          DataCell(Text('1263748874')),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('BNI')),
                                          DataCell(Text('9483984774')),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('BRI')),
                                          DataCell(Text('3748874939')),
                                        ]),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Text('Select Payment',
                          style: TextStyle(
                              fontFamily: FontPicker.medium,
                              color: ColorPicker.primary)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
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
                          'Submit Payment',
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
