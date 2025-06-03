import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:laundry/controllers/customer_controller.dart';
import 'package:laundry/routes.dart';
import 'package:laundry/utils/colors.dart';
import 'package:laundry/utils/sizes.dart';
import 'package:shimmer/shimmer.dart';

class CustomerListPage extends StatefulWidget {
  const CustomerListPage({super.key});

  @override
  State<CustomerListPage> createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  final CustomerController _customerController = Get.put(CustomerController());
  Future<void> _refresh() async {
    _customerController.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: MyColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        title: AnimatedSearchBar(
          label: 'Cari Nama ...',
          controller: _customerController.searchText,
          labelStyle: const TextStyle(fontSize: 16),
          searchStyle: const TextStyle(color: Colors.grey),
          cursorColor: Colors.grey,
          textInputAction: TextInputAction.done,
          autoFocus: false,
          searchDecoration: InputDecoration(
            hintText: 'Search',
            alignLabelWithHint: true,
            // fillColor: Colors.blue,
            // focusColor: Colors.green,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            border: InputBorder.none,
          ),
          onFieldSubmitted: (value) {
            _customerController.searchText.text = value;
            _customerController.fetchData();
          },
          onClose: () {
            _customerController.searchText.text = '';
            _customerController.fetchData();
          },
        ),
        backgroundColor: Colors.white,

        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.add_box, color: MyColors.primary),
        //     onPressed: () {
        //       showDialog(
        //         context: context,
        //         builder: (context) {
        //           return AlertDialog(
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(5),
        //             ),
        //             backgroundColor: Colors.white,
        //             contentPadding: const EdgeInsets.all(10),
        //             content: const CategoryForm(),
        //           );
        //         },
        //       );
        //     },
        //   ),
        // ],
      ),
      backgroundColor: Colors.grey.shade50,
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Obx(() {
          return _customerController.isLoading.value
              ? ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 16,
                    ),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.white,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              )
              : ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(thickness: .5, color: Colors.grey.shade300);
                },
                itemCount: _customerController.customers.length,
                itemBuilder: (context, index) {
                  final customer = _customerController.customers[index];
                  return ListTile(
                    title: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: customer.name ?? '',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: MySizes.fontSizeMd,
                            ),
                          ),
                          TextSpan(
                            text: ' - ${customer.address ?? ''}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: MySizes.fontSizeSm,
                            ),
                          ),
                        ],
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        const Icon(Icons.phone, size: 15),
                        Gap(5),
                        Text(
                          customer.phone!,
                          style: const TextStyle(
                            fontSize: MySizes.fontSizeSm,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      _customerController.dataCustomerId.value = customer.id!;
                      _customerController.dataCustomerName.value =
                          customer.name!;
                      _customerController.dataCustomerPhone.value =
                          customer.phone!;
                      _customerController.dataCustomerAddress.value =
                          customer.address!;
                      Get.toNamed(
                        RouterClass.checkoutPage,
                        arguments: {
                          'customerID': customer.id,
                          'customerName': customer.name,
                          'customerPhone': customer.phone,
                          'customerAddress': customer.address,
                        },
                      );
                    },
                    trailing: Icon(
                      Icons.check_circle,
                      color:
                          _customerController.dataCustomerId.value ==
                                  customer.id
                              ? Colors.green
                              : Colors.grey.shade300,
                    ),
                  );
                },
              );
        }),
      ),
    );
  }
}
