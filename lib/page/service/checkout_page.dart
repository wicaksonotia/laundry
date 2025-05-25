import 'package:chips_choice/chips_choice.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:laundry/controllers/cart_controller.dart';
import 'package:laundry/utils/colors.dart';
import 'package:laundry/utils/lists.dart';
import 'package:laundry/utils/text_form_field_widget.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final CartController _cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: .45,
      maxChildSize: .5,
      minChildSize: .2,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormFieldWidget(
                hint: "Nama Konsumen",
                controller: _cartController.customerNameController,
                filled: true,
              ),
              const Gap(10),
              TextFormFieldWidget(
                hint: "No Handphone",
                keyboardType: TextInputType.number,
                controller: _cartController.customerPhoneController,
                filled: true,
              ),
              const Gap(10),
              TextFormFieldWidget(
                hint: "Alamat",
                maxLines: 3,
                controller: _cartController.customerAddressController,
                filled: true,
              ),
              const Gap(10),
              Divider(),
              const Gap(10),
              TextField(
                inputFormatters: [
                  CurrencyTextInputFormatter.currency(
                    locale: 'id',
                    decimalDigits: 0,
                    symbol: 'Rp.',
                  ),
                ],
                keyboardType: TextInputType.number,
                controller: _cartController.discountController,
                decoration: const InputDecoration(
                  labelText: "Discount",
                  border: OutlineInputBorder(),
                ),
              ),
              const Gap(10),
              ChipsChoice.single(
                wrapped: true,
                padding: EdgeInsets.zero,
                value: _cartController.paymentStatus.value,
                onChanged: (val) => _cartController.paymentStatus.value = val,
                choiceItems: C2Choice.listFrom<bool, Map<String, dynamic>>(
                  source: paymentCategory,
                  value: (i, v) => v['value'] as bool,
                  label: (i, v) => v['nama'] as String,
                ),
                choiceStyle: C2ChipStyle.filled(
                  borderRadius: BorderRadius.circular(25),
                  color: MyColors.notionBgGrey,
                  selectedStyle: const C2ChipStyle(
                    backgroundColor: MyColors.primary,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(Get.context!).size.width * .45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: MyColors.primary),
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: MyColors.primary),
                      ),
                    ),
                  ),
                  const Gap(5),
                  SizedBox(
                    width: MediaQuery.of(Get.context!).size.width * .45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        var discount =
                            _cartController.discountController.text.isNotEmpty
                                ? int.parse(
                                  _cartController.discountController.text
                                      .replaceAll(RegExp('[^0-9]'), ''),
                                )
                                : 0;
                        _cartController.saveCart(discount);
                        Get.back();
                      },
                      child: const Text(
                        'Proccess',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
