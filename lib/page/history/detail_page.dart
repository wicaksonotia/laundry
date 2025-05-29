import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/route_manager.dart';
import 'package:laundry/controllers/history_controller.dart';
import 'package:laundry/utils/colors.dart';
import 'package:laundry/utils/currency.dart';
import 'package:laundry/utils/sizes.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  final dynamic transaction;
  final HistoryController historyController;
  const DetailPage({
    super.key,
    required this.transaction,
    required this.historyController,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final List<String> steps = ['Antri', 'Proses', 'Selesai', 'Diambil'];
  late int initialStep = 0;

  @override
  void initState() {
    super.initState();
    initialStep = 0;
    if (widget.transaction.delivering == true) {
      initialStep = 3;
    } else if (widget.transaction.completed == true) {
      initialStep = 2;
    } else if (widget.transaction.washing == true) {
      initialStep = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade50, // Set your desired background color here
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            children: [
              Stack(
                children: [
                  Container(
                    height: 300,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                        colors: [MyColors.primary, MyColors.secondary],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -100,
                    left: -50,
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white.withAlpha((0.2 * 255).toInt()),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: -60,
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white.withAlpha((0.2 * 255).toInt()),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 70,
                    right: -40,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: MyColors.primary,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 20,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 80,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order ID #${widget.transaction.numerator.toString().padLeft(4, '0').toUpperCase()}',
                          style: TextStyle(
                            fontSize: MySizes.fontSizeLg,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          DateFormat('dd MMM yyyy - HH:mm').format(
                            DateTime.parse(widget.transaction.transactionDate),
                          ),
                          style: TextStyle(
                            fontSize: MySizes.fontSizeSm,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 120, 20, 0),
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyColors.notionBgBlue,
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: MyColors.primary,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.transaction.customerName
                                          .toString()
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontSize: MySizes.fontSizeLg,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      widget.transaction.customerPhone,
                                      style: TextStyle(
                                        fontSize: MySizes.fontSizeSm,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColors.whatsapp,
                              ),
                              child: IconButton(
                                icon: Image.asset('assets/images/whatsapp.png'),
                                onPressed: () {},
                              ),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColors.primary,
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.print,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        Gap(10),
                        Divider(color: Colors.grey.shade300, thickness: 0.5),
                        Gap(20),
                        ...widget.transaction.details.map<Widget>((item) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.serviceName,
                                        style: TextStyle(
                                          fontSize: MySizes.fontSizeMd,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Rp ${CurrencyFormat.convertToIdr(item.unitPrice, 0)}',
                                        style: TextStyle(
                                          fontSize: MySizes.fontSizeSm,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'x${item.quantity.toString()}',
                                    style: TextStyle(
                                      fontSize: MySizes.fontSizeMd,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'Rp ${CurrencyFormat.convertToIdr(item.totalPrice, 0)}',
                                    style: TextStyle(
                                      fontSize: MySizes.fontSizeMd,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        Gap(10),
                        Divider(color: Colors.grey.shade300, thickness: 0.5),
                        Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal',
                              style: TextStyle(fontSize: MySizes.fontSizeMd),
                            ),
                            Text(
                              'Rp ${CurrencyFormat.convertToIdr(widget.transaction.total, 0)}',
                              style: TextStyle(
                                fontSize: MySizes.fontSizeMd,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Discount',
                              style: TextStyle(fontSize: MySizes.fontSizeMd),
                            ),
                            Text(
                              'Rp ${CurrencyFormat.convertToIdr(widget.transaction.discount, 0)}',
                              style: TextStyle(
                                fontSize: MySizes.fontSizeMd,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                fontSize: MySizes.fontSizeLg,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Rp ${CurrencyFormat.convertToIdr(widget.transaction.grandTotal, 0)}',
                              style: TextStyle(
                                fontSize: MySizes.fontSizeLg,
                                color: MyColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Gap(10),
                        Divider(color: Colors.grey.shade300, thickness: 0.5),
                        Gap(10),
                        Center(
                          child: Text(
                            'Status',
                            style: TextStyle(
                              fontSize: MySizes.fontSizeMd,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // Gap(10),
                        // Row(
                        //   children: [
                        //     for (int i = 0; i < steps.length; i++)
                        //       Container(
                        //         width: 77.5,
                        //         height: 70,
                        //         margin: EdgeInsets.only(right: 5),
                        //         padding: const EdgeInsets.symmetric(
                        //           horizontal: 16,
                        //           vertical: 8,
                        //         ),
                        //         decoration: BoxDecoration(
                        //           color:
                        //               initialStep == i
                        //                   ? MyColors.primary
                        //                   : Colors.grey.shade100,
                        //           borderRadius:
                        //               i == 0
                        //                   ? BorderRadius.only(
                        //                     topLeft: Radius.circular(20),
                        //                     bottomLeft: Radius.circular(20),
                        //                   )
                        //                   : i == steps.length - 1
                        //                   ? BorderRadius.only(
                        //                     topRight: Radius.circular(20),
                        //                     bottomRight: Radius.circular(20),
                        //                   )
                        //                   : BorderRadius.circular(0),
                        //         ),
                        //         child: Center(
                        //           child: Text(
                        //             steps[i],
                        //             style: TextStyle(
                        //               color:
                        //                   initialStep == i
                        //                       ? Colors.white
                        //                       : Colors.black54,
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: MySizes.fontSizeSm,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //   ],
                        // ),
                        EasyStepper(
                          padding: EdgeInsets.zero,
                          activeStep: initialStep,
                          lineStyle: const LineStyle(
                            lineLength: 50,
                            lineType: LineType.normal,
                            lineThickness: 2,
                            lineSpace: 1,
                            lineWidth: 10,
                            unreachedLineType: LineType.dashed,
                            defaultLineColor: MyColors.primary,
                            unreachedLineColor: MyColors.notionBgBlue,
                          ),
                          showLoadingAnimation: false,
                          stepShape: StepShape.rRectangle,
                          stepBorderRadius: 10,
                          borderThickness: 2,
                          stepRadius: 20,
                          internalPadding: 0,
                          showStepBorder: true,
                          activeStepBackgroundColor: MyColors.primary,
                          activeStepBorderColor: MyColors.primary,
                          activeStepTextColor: Colors.white,

                          finishedStepTextColor: Colors.white,
                          finishedStepBorderColor: MyColors.primary,
                          finishedStepBackgroundColor: MyColors.notionBgBlue,
                          steps: [
                            ...steps.asMap().entries.map((entry) {
                              String label = entry.value;
                              return EasyStep(
                                customStep: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (entry.key > initialStep) {
                                        initialStep = entry.key;
                                        widget.historyController.updateStatus(
                                          widget.transaction.id,
                                          initialStep,
                                        );
                                        widget.historyController.fetchData();
                                      }
                                    });
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${entry.key + 1}',
                                        style: TextStyle(
                                          color:
                                              initialStep == entry.key
                                                  ? Colors.white
                                                  : Colors.black54,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                customTitle: Text(
                                  label,
                                  textAlign: TextAlign.center,
                                ),
                              );

                              // EasyStep(
                              //   customStep: CircleAvatar(
                              //     backgroundColor:
                              //         initialStep == idx
                              //             ? Colors.red
                              //             : MyColors.notionBgBlue,
                              //     radius: 10,
                              //   ),
                              //   title: label,
                              //   topTitle:
                              //       idx % 2 ==
                              //       1, // alternate top/bottom for visual variety
                              // );
                            }),
                            // EasyStep(
                            //   customStep: CircleAvatar(
                            //     child: CircleAvatar(
                            //       backgroundColor:
                            //           initialStep == 0
                            //               ? Colors.red
                            //               : MyColors.notionBgBlue,
                            //     ),
                            //   ),
                            //   title: 'Menunggu',
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
