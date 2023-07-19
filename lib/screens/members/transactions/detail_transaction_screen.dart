import 'package:gofarmin_app/controllers/auth_controller.dart';
import 'package:gofarmin_app/controllers/members/transaction_controller.dart';
import 'package:gofarmin_app/controllers/profile_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/components/label_component.dart';
import 'package:gofarmin_app/screens/members/transactions/transaction_screen.dart';
import 'package:gofarmin_app/utils/http_helpers.dart';
import 'package:intl/intl.dart' as intl;

class DetailTransactionMemberScreen extends StatefulWidget {
  final String invoice;
  const DetailTransactionMemberScreen({super.key, required this.invoice});

  @override
  State<DetailTransactionMemberScreen> createState() =>
      _DetailTransactionMemberScreenState();
}

class _DetailTransactionMemberScreenState
    extends State<DetailTransactionMemberScreen> {
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
                    Get.to(const TransactionMemberScreen());
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
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
