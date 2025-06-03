import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:laundry/controllers/history_controller.dart';
import 'package:laundry/controllers/service_controller.dart';
import 'package:laundry/page/history/stepper_status.dart';
import 'package:laundry/page/service/increment_and_decrement.dart';
import 'package:laundry/page/service/product_price.dart';
import 'package:laundry/utils/box_container.dart';
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
  final ServiceController _serviceController = Get.find<ServiceController>();

  @override
  void initState() {
    super.initState();
    if (widget.transaction.karpet == true) {
      _serviceController.fetchProductKarpet();
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

                  // BUTTON BACK AND ORDER ID
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

                  // ORDER DETAIL
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 120, 20, 0),
                    padding: const EdgeInsets.all(15),
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

                        // TRANSACTION DETAILS
                        ...(widget.transaction.karpet == true
                            ? [
                              Obx(() {
                                if (_serviceController.isLoading.value) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (_serviceController
                                    .servicesKarpet
                                    .isEmpty) {
                                  return const Center(
                                    child: Text('No data found.'),
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      ListView.builder(
                                        padding: const EdgeInsets.fromLTRB(
                                          10,
                                          0,
                                          10,
                                          10,
                                        ),
                                        scrollDirection: Axis.vertical,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount:
                                            _serviceController
                                                .servicesKarpet
                                                .length,
                                        shrinkWrap: true,
                                        itemBuilder: (_, index) {
                                          // var dataIdProduct = _serviceController.productItems[index].idProduct!;
                                          var dataServiceName =
                                              _serviceController
                                                  .servicesKarpet[index]
                                                  .serviceName!;
                                          var dataPhoto =
                                              _serviceController
                                                  .servicesKarpet[index]
                                                  .photo!;
                                          var dataPrice =
                                              _serviceController
                                                  .servicesKarpet[index]
                                                  .price!;
                                          var dataSatuan =
                                              _serviceController
                                                  .servicesKarpet[index]
                                                  .satuan!;

                                          return BoxContainer(
                                            margin: const EdgeInsets.only(
                                              top: 10,
                                            ),
                                            padding: const EdgeInsets.all(5),
                                            shadow: true,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                    right: 5,
                                                  ),
                                                  width: 80,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: MemoryImage(
                                                        dataPhoto,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          10,
                                                        ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          dataServiceName,
                                                          style: const TextStyle(
                                                            fontSize:
                                                                MySizes
                                                                    .fontSizeMd,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            ProductPrice(
                                                              dataPrice:
                                                                  dataPrice,
                                                              dataSatuan:
                                                                  dataSatuan,
                                                            ),
                                                            const Spacer(),
                                                            IncrementAndDecrement(
                                                              dataProduct:
                                                                  _serviceController
                                                                      .servicesKarpet[index],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                }
                              }),
                            ]
                            : [
                              Gap(10),
                              Column(
                                children:
                                    widget.transaction.details.map<Widget>((
                                      item,
                                    ) {
                                      return Container(
                                        margin: const EdgeInsets.only(
                                          bottom: 10,
                                        ),
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
                                                      fontSize:
                                                          MySizes.fontSizeMd,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    'Rp ${CurrencyFormat.convertToIdr(item.unitPrice, 0)}',
                                                    style: TextStyle(
                                                      fontSize:
                                                          MySizes.fontSizeSm,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                              ),
                              Gap(10),
                              Divider(
                                color: Colors.grey.shade300,
                                thickness: 0.5,
                              ),
                              Gap(10),

                              // SUBTOTAL
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Subtotal',
                                    style: TextStyle(
                                      fontSize: MySizes.fontSizeMd,
                                    ),
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

                              // DISCOUNT
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Discount',
                                    style: TextStyle(
                                      fontSize: MySizes.fontSizeMd,
                                    ),
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

                              // TOTAL
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            ]),

                        // STEPPER STATUS
                        if (widget.transaction.customerName
                                .toString()
                                .toUpperCase() !=
                            'SELF SERVICE') ...[
                          Divider(color: Colors.grey.shade300, thickness: 0.5),
                          Gap(10),
                          StepperStatus(
                            transaction: widget.transaction,
                            historyController: widget.historyController,
                          ),
                        ],
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
