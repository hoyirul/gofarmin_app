import 'package:gofarmin_app/controllers/investors/goat_controller.dart';
import 'package:gofarmin_app/controllers/investors/transaction_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/components/button_alert_component.dart';
import 'package:gofarmin_app/screens/components/button_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/components/confirm_dialog_component.dart';
import 'package:gofarmin_app/screens/components/input_component.dart';
import 'package:gofarmin_app/screens/components/label_component.dart';
import 'package:gofarmin_app/screens/investors/invests/detail_member_screen.dart';
import 'package:gofarmin_app/screens/investors/invests/payment_screen.dart';
import 'package:gofarmin_app/utils/http_helpers.dart';
import 'package:intl/intl.dart' as intl;

class DetailGoatInvestorScreen extends StatefulWidget {
  final int goatId;
  const DetailGoatInvestorScreen({super.key, required this.goatId});

  @override
  State<DetailGoatInvestorScreen> createState() =>
      _DetailGoatInvestorScreenState();
}

class _DetailGoatInvestorScreenState extends State<DetailGoatInvestorScreen> {
  GoatController goatController = Get.put(GoatController());
  final TransactionController transactionController =
      Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    final goats = goatController.getById(widget.goatId);
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
                  child: FutureBuilder(
                    future: goats,
                    builder: (context, snapshot) {
                      if (snapshot.data?.image == null) {
                        return Image.network(
                          '${HttpHelper().url}/images/members/default-member.jpg',
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                        );
                      } else {
                        return Image.network(
                          fit: BoxFit.fitWidth,
                          '${HttpHelper().url}/storage/${snapshot.data?.image}',
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
                child: FutureBuilder(
                  future: goats,
                  builder: (context, snapshot) => InkWell(
                    onTap: () => Get.to(
                        DetailMemberInvestorScreen(
                            id: snapshot.data!.uMemberId),
                        transition: Transition.native),
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
                    future: goats,
                    builder: (context, snapshot) {
                      return Text(
                        '${snapshot.data?.goatName}',
                        style: const TextStyle(
                            fontFamily: FontPicker.bold,
                            color: ColorPicker.dark,
                            fontSize: 22),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                  future: goats,
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
                              'Age <> ${snapshot.data?.age} months',
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
                      future: goats,
                      builder: (context, snapshot) {
                        return Text(
                          '${snapshot.data?.information}',
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
                const LabelComponent(label: 'Qty of Goat'),
                const SizedBox(
                  height: 5,
                ),
                InputComponent(
                    textEditingController: transactionController.qtyController,
                    hintText: 'Qty of goat',
                    obscuredText: false,
                    colors: ColorPicker.greyAccent),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: goats,
                  builder: (context, snapshot) => ButtonComponent(
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
                                          transactionController.addTransaction(
                                              snapshot.data?.id,
                                              snapshot.data?.price,
                                              'buy'),
                                      child: const ButtonAlertComponent(
                                        text: 'Continue',
                                        colors: ColorPicker.primary,
                                      )),
                                );
                              },
                            );
                          },
                          child: const Text(
                            'Continue Invest',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: FontPicker.bold,
                                color: ColorPicker.white),
                          ))),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
