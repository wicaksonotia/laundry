import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:intl/intl.dart';
import 'package:laundry/controllers/history_controller.dart';
import 'package:laundry/utils/box_container.dart';
import 'package:laundry/utils/colors.dart';
import 'package:laundry/utils/currency.dart';
import 'package:laundry/utils/sizes.dart';
import 'package:shimmer/shimmer.dart';
import 'package:laundry/page/history/detail_page.dart';

class HistoryList extends StatefulWidget {
  final HistoryController historyController;
  const HistoryList({super.key, required this.historyController});

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.historyController.isLoading.value) {
        return Center(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      } else {
        Map<String, List<dynamic>> resultDataMap = {};
        for (var item in widget.historyController.transactions) {
          String formattedDate = DateFormat(
            'dd MMMM yyyy',
          ).format(DateTime.parse(item.transactionDate!));
          if (!resultDataMap.containsKey(formattedDate)) {
            resultDataMap[formattedDate] = [];
          }
          resultDataMap[formattedDate]!.add(item);
        }
        // resultDataMap.forEach((key, value) {
        // print(
        //     'Date: $key, Transactions: ${value.map((item) => item.toJson()).toList()}');
        // });
        return GroupListView(
          sectionsCount: resultDataMap.keys.toList().length,
          countOfItemInSection: (int section) {
            return resultDataMap.values.toList()[section].length;
          },
          itemBuilder: (BuildContext context, IndexPath index) {
            var items =
                resultDataMap.values.toList()[index.section][index.index];
            var kondisi = 'Masih Antri';
            if (items.delivering!) {
              kondisi = 'Sudah Diambil';
            } else if (items.completed!) {
              kondisi = 'Selesai';
            } else if (items.washing! || items.drying! || items.ironing!) {
              kondisi = 'Proses';
            }
            return GestureDetector(
              onTap: () {
                Get.to(
                  () => DetailPage(
                    transaction: items,
                    historyController: widget.historyController,
                  ),
                );
              },
              child: BoxContainer(
                padding: const EdgeInsets.all(10.0),
                radius: 0,
                shadow: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order ID #${items.numerator.toString().padLeft(4, '0').toUpperCase()}',
                          style: TextStyle(
                            fontSize: MySizes.fontSizeMd,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              MySizes.buttonElevation,
                            ),
                            color: MyColors.notionBgYellow,
                          ),
                          child: Text(
                            kondisi,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: MySizes.fontSizeXsm,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: BoxContainer(
                        width: 50,
                        height: 50,
                        radius: 5,
                        backgroundColor: MyColors.notionBgYellow,
                        borderColor: Colors.grey.shade200,
                        child: Center(
                          child: Image.asset(
                            'assets/images/washing-machine.png',
                            width: 35,
                            height: 35,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            items.customerName.toString().toUpperCase(),
                            style: const TextStyle(
                              fontSize: MySizes.fontSizeMd,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 15),
                              Gap(5),
                              Text(
                                items.customerAddress.toString().toUpperCase(),
                                style: const TextStyle(
                                  fontSize: MySizes.fontSizeSm,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          const Icon(Icons.calendar_month, size: 15),
                          Gap(5),
                          Text(
                            DateFormat(
                              'dd MMM yyyy - HH:mm',
                            ).format(DateTime.parse(items.transactionDate!)),
                            style: const TextStyle(
                              fontSize: MySizes.fontSizeSm,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                    items.grandTotal,
                                    0,
                                  ),
                                  style: const TextStyle(
                                    fontSize: MySizes.fontSizeMd,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '* ${(items.paymentStatus ?? false) ? 'sudah bayar' : 'belum bayar'}',
                            style: TextStyle(
                              fontSize: MySizes.fontSizeXsm,
                              color:
                                  items.paymentStatus ?? false
                                      ? Colors.grey
                                      : Colors.red,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          groupHeaderBuilder: (BuildContext context, int section) {
            return Container(
              width: double.infinity,
              height: 60,
              padding: const EdgeInsets.only(left: 16, right: 10),
              decoration: BoxDecoration(
                color: MyColors.notionBgBlue,
                border: Border(
                  top: BorderSide(color: Colors.grey[100]!, width: 1),
                  bottom: BorderSide(color: Colors.grey[100]!, width: 1),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('dd').format(
                      DateFormat(
                        'dd MMMM yyyy',
                      ).parse(resultDataMap.keys.toList()[section]),
                    ),
                    style: const TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('EEEE').format(
                          DateFormat(
                            'dd MMMM yyyy',
                          ).parse(resultDataMap.keys.toList()[section]),
                        ),
                        style: const TextStyle(
                          fontSize: MySizes.fontSizeMd,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat('MMMM yyyy').format(
                          DateFormat(
                            'dd MMMM yyyy',
                          ).parse(resultDataMap.keys.toList()[section]),
                        ),
                        style: const TextStyle(
                          fontSize: MySizes.fontSizeSm,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      CurrencyFormat.convertToIdr(
                        widget.historyController.transactions
                            .where(
                              (element) =>
                                  DateFormat('dd MMMM yyyy').format(
                                    DateTime.parse(element.transactionDate!),
                                  ) ==
                                  resultDataMap.keys.toList()[section],
                            )
                            .fold<int>(
                              0,
                              (sum, element) => sum + element.grandTotal!,
                            ),
                        0,
                      ),
                      style: const TextStyle(
                        fontSize: MySizes.fontSizeLg,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 2),
          sectionSeparatorBuilder: (context, section) => SizedBox(height: 10),
        );
      }
    });
  }
}
