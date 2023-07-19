import 'dart:io';
import 'package:gofarmin_app/controllers/auth_controller.dart';
import 'package:gofarmin_app/controllers/investors/transaction_controller.dart';
import 'package:gofarmin_app/controllers/profile_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/components/button_alert_component.dart';
import 'package:gofarmin_app/screens/components/button_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/components/confirm_dialog_component.dart';
import 'package:gofarmin_app/screens/components/label_component.dart';
import 'package:gofarmin_app/utils/http_helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;

class PaymentInvestorScreen extends StatefulWidget {
  final String invoice;
  const PaymentInvestorScreen({super.key, required this.invoice});

  @override
  State<PaymentInvestorScreen> createState() => _PaymentInvestorScreenState();
}

class _PaymentInvestorScreenState extends State<PaymentInvestorScreen> {
  AuthController authController = Get.put(AuthController());
  ProfileController profileController = Get.put(ProfileController());
  TransactionController transactionController =
      Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    final transactions = transactionController.showByInvoice(widget.invoice);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(0),
                height: 225,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(50)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                  child: FutureBuilder(
                    future: transactions,
                    builder: (context, snapshot) {
                      if (snapshot.data?.goat.image == null) {
                        return Image.network(
                          '${HttpHelper().url}/images/members/default-member.jpg',
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                        );
                      } else {
                        return Image.network(
                          fit: BoxFit.fitWidth,
                          '${HttpHelper().url}/storage/${snapshot.data?.goat.image}',
                          width: MediaQuery.of(context).size.width,
                        );
                      }
                    },
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
                        return FutureBuilder(
                          future: transactions,
                          builder: (context, snapshot) =>
                              ConfirmDialogComponent(
                            message: 'Are you sure to cancel this transaction?',
                            confirm: InkWell(
                                onTap: () => transactionController
                                    .destroyById(snapshot.data?.id),
                                child: const ButtonAlertComponent(
                                  text: 'Yes',
                                  colors: ColorPicker.primary,
                                )),
                          ),
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: FutureBuilder(
                    future: transactions,
                    builder: (context, snapshot) => Text(
                      '${snapshot.data?.goat.goatName}',
                      style: const TextStyle(
                          fontFamily: FontPicker.bold,
                          color: ColorPicker.dark,
                          fontSize: 22),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                  future: transactions,
                  builder: (context, snapshot) {
                    return Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text:
                                          'Rp ${(snapshot.data?.price == null) ? 0 : intl.NumberFormat.decimalPattern().format(snapshot.data?.price)}',
                                      style: const TextStyle(
                                          fontFamily: FontPicker.bold,
                                          color: ColorPicker.primary,
                                          fontSize: 22)),
                                  const TextSpan(
                                      text: ' / item',
                                      style: TextStyle(
                                          fontFamily: FontPicker.medium,
                                          color: ColorPicker.danger,
                                          fontSize: 16)),
                                ]),
                              )),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Age <> ${snapshot.data?.goat.age} months',
                              style: const TextStyle(
                                  color: ColorPicker.grey,
                                  fontFamily: FontPicker.medium,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FutureBuilder(
                      future: transactions,
                      builder: (context, snapshot) {
                        return Text(
                          '${snapshot.data?.goat.information}',
                          style: const TextStyle(
                              fontFamily: FontPicker.regular,
                              color: ColorPicker.grey,
                              fontSize: 12),
                        );
                      }),
                ),
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
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FutureBuilder(
                      future: transactions,
                      builder: (context, snapshot) => Text(
                        '${snapshot.data?.invoice}',
                        style: const TextStyle(
                            color: ColorPicker.dark,
                            fontFamily: FontPicker.medium,
                            fontSize: 16),
                      ),
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
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FutureBuilder(
                            future: transactions,
                            builder: (context, snapshot) => Text(
                              '${snapshot.data?.qty} Goats',
                              style: const TextStyle(
                                  color: ColorPicker.dark,
                                  fontFamily: FontPicker.medium,
                                  fontSize: 16),
                            ),
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
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FutureBuilder(
                            future: transactions,
                            builder: (context, snapshot) => Text(
                              '${snapshot.data?.price}',
                              style: const TextStyle(
                                  color: ColorPicker.dark,
                                  fontFamily: FontPicker.medium,
                                  fontSize: 16),
                            ),
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
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FutureBuilder(
                      future: transactions,
                      builder: (context, snapshot) => Text(
                        '${snapshot.data?.total}',
                        style: const TextStyle(
                            color: ColorPicker.dark,
                            fontFamily: FontPicker.medium,
                            fontSize: 16),
                      ),
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
                          child: Obx(() => transactionController
                                      .selectedImage !=
                                  null
                              ? Image.file(transactionController.selectedImage!)
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
                                  transactionController
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
                              return FutureBuilder(
                                future: transactions,
                                builder: (context, snapshot) =>
                                    ConfirmDialogComponent(
                                  message: 'Are you sure?',
                                  confirm: InkWell(
                                      onTap: () => transactionController
                                          .uploadImage(snapshot.data?.id),
                                      child: const ButtonAlertComponent(
                                        text: 'Yes',
                                        colors: ColorPicker.primary,
                                      )),
                                ),
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
