import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laundry/controllers/history_controller.dart';
import 'package:laundry/drawer/nav_drawer.dart' as custom_drawer;
import 'package:laundry/page/history/stepper_page.dart';
import 'package:laundry/utils/box_container.dart';
import 'package:laundry/utils/colors.dart';
import 'package:laundry/utils/currency.dart';
import 'package:laundry/utils/sizes.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final HistoryController _historyController = Get.find<HistoryController>();

  @override
  Widget build(BuildContext context) {
    int activeStep = 0; // Default to the first step
    return Scaffold(
      drawer: custom_drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text(
          'History Page',
          style: TextStyle(
            fontSize: MySizes.fontSizeLg,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: MyColors.notionBgGrey,
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: _historyController.transactions.length,
          itemBuilder: (context, index) {
            final transaction = _historyController.transactions[index];
            var washing = transaction.washing;
            var drying = transaction.drying;
            var ironing = transaction.ironing;
            var completed = transaction.completed;
            if (washing == true) {
              activeStep = 1;
            }
            if (drying == true) {
              activeStep = 2;
            }
            if (ironing == true) {
              activeStep = 3;
            }
            if (completed == true) {
              activeStep = 4;
            }
            return BoxContainer(
              margin: const EdgeInsets.only(bottom: 10.0),
              padding: const EdgeInsets.all(10.0),
              radius: MySizes.cardRadiusSm,
              shadow: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: BoxContainer(
                      width: 50,
                      height: 50,
                      radius: 5,
                      backgroundColor: MyColors.notionBgGreen,
                      borderColor: Colors.grey.shade200,
                      child: Center(
                        child: Image.asset(
                          'assets/images/washing-machine.png',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      transaction.customerName.toUpperCase(),
                      style: const TextStyle(
                        fontSize: MySizes.fontSizeLg,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat(
                        'dd MMM yyyy - HH:mm',
                      ).format(DateTime.parse(transaction.transactionDate!)),
                      style: const TextStyle(
                        fontSize: MySizes.fontSizeMd,
                        color: Colors.grey,
                      ),
                    ),
                    trailing: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          MySizes.buttonElevation,
                        ),
                        color:
                            activeStep == 4
                                ? MyColors.notionBgBlue
                                : MyColors.notionBgGrey,
                      ),
                      child: Text(
                        activeStep == 4 ? 'Selesai' : 'Proses',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Divider(color: Colors.grey.shade200, thickness: 1),
                  StepperPage(activeStep: activeStep),
                  Divider(color: Colors.grey.shade200, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Rp ',
                              style: const TextStyle(
                                fontSize: MySizes.fontSizeMd,
                                color: Colors.black87,
                              ),
                              children: [
                                TextSpan(
                                  text: CurrencyFormat.convertToIdr(
                                    transaction.total,
                                    0,
                                  ),
                                  style: const TextStyle(
                                    fontSize: MySizes.fontSizeXl,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '* ${(transaction.paymentStatus ?? false) ? 'SUDAH BAYAR' : 'BELUM BAYAR'}',
                            style: TextStyle(
                              fontSize: MySizes.fontSizeSm,
                              fontWeight: FontWeight.bold,
                              color:
                                  transaction.paymentStatus ?? false
                                      ? Colors.black87
                                      : Colors.red,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: MyColors.primary,
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: MySizes.iconSm,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
