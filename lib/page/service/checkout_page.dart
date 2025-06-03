import 'package:chips_choice/chips_choice.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:laundry/controllers/cart_controller.dart';
import 'package:laundry/routes.dart';
import 'package:laundry/utils/colors.dart';
import 'package:laundry/utils/lists.dart';
import 'package:laundry/utils/sizes.dart';
import 'package:laundry/utils/text_form_field_widget.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final CartController _cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    // Use args as needed, for example:
    if (args != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _cartController.customerID.value = args['customerID'] ?? 0;
        _cartController.customerName.value = args['customerName'] ?? '';
        _cartController.customerPhone.value = args['customerPhone'] ?? '';
        _cartController.customerAddress.value = args['customerAddress'] ?? '';
      });
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
                        Get.toNamed(RouterClass.servicePage);
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
                          'Form Pemesanan',
                          style: TextStyle(
                            fontSize: MySizes.fontSizeLg,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(20, 120, 20, 0),
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // TextFormFieldWidget(
                            //   hint: "Nama Konsumen",
                            //   controller: _cartController.customerNameController,
                            //   filled: true,
                            //   suffixIcon: Icons.arrow_forward_ios,
                            //   onChanged: (value) {
                            //     _cartController.customerNameController.text =
                            //         value.toUpperCase();
                            //   },
                            // ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(RouterClass.customerListPage);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _cartController.customerName.value.isEmpty
                                          ? "Nama Konsumen"
                                          : _cartController.customerName.value,
                                      style: TextStyle(
                                        fontSize: MySizes.fontSizeSm,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: MyColors.primary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Gap(10),
                            // TextFormFieldWidget(
                            //   hint: "No Handphone",
                            //   keyboardType: TextInputType.number,
                            //   controller:
                            //       _cartController.customerPhoneController,
                            //   filled: true,
                            // ),
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.white,
                              ),
                              child: Text(
                                _cartController.customerPhone.isEmpty
                                    ? "No Handphone"
                                    : _cartController.customerPhone.value,
                                style: TextStyle(
                                  fontSize: MySizes.fontSizeSm,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                            const Gap(10),
                            // TextFormFieldWidget(
                            //   height: 100,
                            //   hint: "Alamat",
                            //   controller:
                            //       _cartController.customerAddressController,
                            //   filled: true,
                            //   maxLines: 3,
                            //   keyboardType: TextInputType.multiline,
                            // ),
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.white,
                              ),
                              child: Text(
                                _cartController.customerAddress.isEmpty
                                    ? "Alamat"
                                    : _cartController.customerAddress.value,
                                style: TextStyle(
                                  fontSize: MySizes.fontSizeSm,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                            const Gap(10),
                            Text(
                              "Parfum",
                              style: TextStyle(
                                fontSize: MySizes.fontSizeSm,
                                color: Colors.black,
                              ),
                            ),
                            const Gap(5),
                            ChipsChoice.single(
                              wrapped: true,
                              padding: EdgeInsets.zero,
                              value: _cartController.yaTidak.value,
                              onChanged:
                                  (val) => _cartController.yaTidak.value = val,
                              choiceItems:
                                  C2Choice.listFrom<bool, Map<String, dynamic>>(
                                    source: yaTidak,
                                    value: (i, v) => v['value'] as bool,
                                    label: (i, v) => v['nama'] as String,
                                  ),
                              choiceStyle: C2ChipStyle.filled(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColors.notionBgGrey,
                                selectedStyle: const C2ChipStyle(
                                  backgroundColor: Colors.redAccent,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const Gap(15),
                            TextFormFieldWidget(
                              height: 100,
                              hint: "Catatan",
                              controller: _cartController.catatanController,
                              filled: true,
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              onChanged: (value) {
                                _cartController
                                    .catatanController
                                    .value = TextEditingValue(
                                  text: value.toUpperCase(),
                                  selection: TextSelection.collapsed(
                                    offset: value.length,
                                  ),
                                );
                              },
                            ),
                            const Gap(10),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 0.5,
                            ),
                            const Gap(10),
                            TextFormFieldWidget(
                              inputFormatters: [
                                CurrencyTextInputFormatter.currency(
                                  locale: 'id',
                                  decimalDigits: 0,
                                  symbol: 'Rp.',
                                ),
                              ],
                              hint: "Discount",
                              keyboardType: TextInputType.number,
                              controller: _cartController.discountController,
                            ),
                            const Gap(10),
                            ChipsChoice.single(
                              wrapped: true,
                              padding: EdgeInsets.zero,
                              value: _cartController.paymentStatus.value,
                              onChanged:
                                  (val) =>
                                      _cartController.paymentStatus.value = val,
                              choiceItems:
                                  C2Choice.listFrom<bool, Map<String, dynamic>>(
                                    source: paymentCategory,
                                    value: (i, v) => v['value'] as bool,
                                    label: (i, v) => v['nama'] as String,
                                  ),
                              choiceStyle: C2ChipStyle.filled(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColors.notionBgGrey,
                                selectedStyle: const C2ChipStyle(
                                  backgroundColor: Colors.redAccent,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const Gap(30),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  var discount =
                                      _cartController
                                              .discountController
                                              .text
                                              .isNotEmpty
                                          ? int.parse(
                                            _cartController
                                                .discountController
                                                .text
                                                .replaceAll(
                                                  RegExp('[^0-9]'),
                                                  '',
                                                ),
                                          )
                                          : 0;
                                  _cartController.saveCart(discount);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      MyColors.primary, // Button color
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: const Text(
                                  'Simpan',
                                  style: TextStyle(
                                    fontSize: MySizes.fontSizeMd,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
