import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:laundry/controllers/service_controller.dart';
import 'package:laundry/page/service/increment_and_decrement.dart';
import 'package:laundry/page/service/product_price.dart';
import 'package:laundry/utils/box_container.dart';
import 'package:laundry/utils/sizes.dart';
import 'package:shimmer/shimmer.dart';

class ServiceListView extends StatelessWidget {
  ServiceListView({super.key});

  final ServiceController _serviceController = Get.find<ServiceController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          _serviceController.isLoading.value
              ? ListView.builder(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: _serviceController.services.length,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return BoxContainer(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(5),
                    shadow: true,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            margin: const EdgeInsets.only(right: 5),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: double.infinity,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const Gap(5),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: double.infinity,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const Gap(5),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: 100,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
              : ListView.builder(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: _serviceController.services.length,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  // var dataIdProduct = _serviceController.productItems[index].idProduct!;
                  var _dataServiceName =
                      _serviceController.services[index].serviceName!;
                  var _dataPhoto = _serviceController.services[index].photo!;
                  var dataPrice = _serviceController.services[index].price!;
                  var dataSatuan = _serviceController.services[index].satuan!;

                  return BoxContainer(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(5),
                    shadow: true,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(_dataPhoto),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _dataServiceName,
                                  style: const TextStyle(
                                    fontSize: MySizes.fontSizeMd,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    ProductPrice(
                                      dataPrice: dataPrice,
                                      dataSatuan: dataSatuan,
                                    ),
                                    const Spacer(),
                                    IncrementAndDecrement(
                                      dataProduct:
                                          _serviceController.services[index],
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
    );
  }
}
