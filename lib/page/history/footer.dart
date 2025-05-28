import 'package:laundry/controllers/history_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:laundry/utils/colors.dart';
import 'package:laundry/utils/currency.dart';
import 'package:laundry/utils/sizes.dart';

class FooterReport extends StatefulWidget {
  final HistoryController historyController;
  const FooterReport({super.key, required this.historyController});

  @override
  State<FooterReport> createState() => _FooterReportState();
}

class _FooterReportState extends State<FooterReport> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: MediaQuery.of(context).size.height * .07,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 7,
          ),
        ],
        color: Colors.white,
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Total: ',
                    style: const TextStyle(
                      fontSize: MySizes.fontSizeLg,
                      color: Colors.black87,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Rp ',
                        style: TextStyle(
                          fontSize: MySizes.fontSizeMd,
                          color: Colors.black87,
                        ),
                      ),
                      TextSpan(
                        text: CurrencyFormat.convertToIdr(
                          widget.historyController.total.value,
                          0,
                        ),
                        style: const TextStyle(
                          fontSize: MySizes.fontSizeXl,
                          color: MyColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    widget.historyController.toggleSideBar();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    backgroundColor: MyColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    textStyle: const TextStyle(
                      fontSize: MySizes.fontSizeMd,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.filter_alt_outlined, color: Colors.white),
                      Gap(5),
                      Text('Filter', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
