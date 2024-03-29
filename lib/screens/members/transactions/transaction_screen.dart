import 'package:gofarmin_app/controllers/members/portofolio_controller.dart';
import 'package:gofarmin_app/controllers/members/transaction_controller.dart';
import 'package:gofarmin_app/pickers/color_pickers.dart';
import 'package:gofarmin_app/pickers/font_pickers.dart';
import 'package:gofarmin_app/screens/components/circle_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofarmin_app/screens/members/home/home_screen.dart';
import 'package:gofarmin_app/screens/members/transactions/detail_transaction_screen.dart';
import 'package:intl/intl.dart' as intl;

class TransactionMemberScreen extends StatefulWidget {
  const TransactionMemberScreen({super.key});

  @override
  State<TransactionMemberScreen> createState() =>
      _TransactionMemberScreenState();
}

class _TransactionMemberScreenState extends State<TransactionMemberScreen> {
  PortofolioController portofolioController = Get.put(PortofolioController());
  TransactionController transactionController =
      Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    final portofolios = portofolioController.showPortofolio();
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(0),
                height: 200,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(50)),
                    color: ColorPicker.primary),
              ),
              const Positioned(
                right: -10,
                top: -20,
                child: CircleComponent(height: 150, width: 150),
              ),
              const Positioned(
                left: -25,
                top: 50,
                child: CircleComponent(height: 100, width: 100),
              ),
              Positioned(
                left: 25,
                top: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Portofolio',
                      style: TextStyle(
                          fontFamily: FontPicker.regular,
                          fontSize: 12,
                          color: ColorPicker.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    FutureBuilder(
                      future: portofolios,
                      builder: (context, snapshot) {
                        return Text(
                          'Rp ${(snapshot.data == null) ? 0 : snapshot.data}',
                          style: const TextStyle(
                              fontFamily: FontPicker.bold,
                              fontSize: 30,
                              color: ColorPicker.white),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 25,
                top: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FutureBuilder(
                      future: portofolioController.getAvgGoat(),
                      builder: (context, snapshot) => Text(
                        '${snapshot.data ?? 0} / goat',
                        style: const TextStyle(
                            fontFamily: FontPicker.regular,
                            fontSize: 14,
                            color: ColorPicker.white),
                      ),
                    ),
                    FutureBuilder(
                      future: portofolioController.getCountGoat(),
                      builder: (context, snapshot) => Text(
                        '${snapshot.data} Goats',
                        style: const TextStyle(
                            fontFamily: FontPicker.regular,
                            fontSize: 14,
                            color: ColorPicker.white),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 50,
                right: 25,
                child: InkWell(
                  onTap: () => Get.to(const HomeMemberScreen(),
                      transition: Transition.fadeIn),
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
            height: 20,
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
                      'Transactions',
                      style: TextStyle(
                          fontFamily: FontPicker.semibold,
                          color: ColorPicker.dark,
                          fontSize: 18),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Obx(() {
                  if (transactionController.isLoading.value) {
                    return const CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: transactionController.transactionList.length,
                      itemBuilder: (context, index) {
                        final row =
                            transactionController.transactionList[index];
                        return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorPicker.white,
                                boxShadow: const [
                                  BoxShadow(
                                      color: ColorPicker.greyLight,
                                      offset: Offset(0, 1),
                                      blurRadius: 1)
                                ]),
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                    DetailTransactionMemberScreen(
                                        invoice: row.invoice),
                                    transition: Transition.circularReveal);
                              },
                              child: ListTile(
                                  contentPadding: const EdgeInsets.all(5),
                                  title: Text(
                                    row.goatName,
                                    style: const TextStyle(
                                        fontFamily: FontPicker.semibold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        '${row.qty} Goats - ${row.price} / goats',
                                        style: const TextStyle(
                                            fontFamily: FontPicker.regular,
                                            fontSize: 12),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${row.type} - ${row.status}',
                                        style: const TextStyle(
                                            fontFamily: FontPicker.regular,
                                            fontSize: 12),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        intl.DateFormat('dd MMMM yyyy HH:mm:ss')
                                            .format(row.createdAt),
                                        style: const TextStyle(
                                            fontFamily: FontPicker.regular,
                                            fontSize: 12,
                                            color: ColorPicker.orange),
                                      ),
                                    ],
                                  ),
                                  trailing: Wrap(
                                    children: [
                                      Text(
                                        '${intl.NumberFormat.decimalPattern().format(row.total / 1000)}K',
                                        style: TextStyle(
                                            fontFamily: FontPicker.semibold,
                                            color: (row.type == 'buy')
                                                ? ColorPicker.primary
                                                : ColorPicker.danger,
                                            fontSize: 20),
                                      ),
                                    ],
                                  )),
                            ));
                      },
                    );
                  }
                }),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
