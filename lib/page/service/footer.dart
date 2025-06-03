import 'package:badges/badges.dart' as badges;
import 'package:laundry/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:laundry/controllers/service_controller.dart';
import 'package:laundry/page/service/cart_page.dart';
import 'package:laundry/routes.dart';
import 'package:laundry/utils/colors.dart';
import 'package:laundry/utils/currency.dart';
import 'package:laundry/utils/sizes.dart';

class FooterService extends StatefulWidget {
  const FooterService({super.key});

  @override
  State<FooterService> createState() => _FooterServiceState();
}

class _FooterServiceState extends State<FooterService> {
  final CartController _cartController = Get.find<CartController>();
  final ServiceController _serviceController = Get.find<ServiceController>();

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
      child: Obx(() {
        bool _isButtonDisabled = _cartController.cartList.length == 0;
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const CartPage(),
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  badges.Badge(
                    badgeContent: Text(
                      _cartController.totalAllQuantity.value.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    badgeAnimation: const badges.BadgeAnimation.fade(
                      animationDuration: Duration(milliseconds: 400),
                    ),
                    child: const Icon(
                      Icons.shopping_bag,
                      size: 30,
                      color: MyColors.primary,
                    ),
                  ),
                  const Gap(10),
                  verticalSeparator(),
                  RichText(
                    text: TextSpan(
                      text: 'Rp ',
                      style: const TextStyle(
                        fontSize: MySizes.fontSizeMd,
                        color: MyColors.primary,
                      ),
                      children: [
                        TextSpan(
                          text: CurrencyFormat.convertToIdr(
                            _cartController.totalPrice.value,
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
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                _isButtonDisabled
                    ? null
                    : _serviceController.category.value == 'Self Service'
                    ? _cartController.saveCart(0)
                    : Get.toNamed(RouterClass.checkoutPage);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
                backgroundColor:
                    _isButtonDisabled
                        ? MyColors.notionBgGrey
                        : MyColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                textStyle: const TextStyle(
                  fontSize: MySizes.fontSizeMd,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.save,
                    color: _isButtonDisabled ? Colors.black : Colors.white,
                  ),
                  Gap(5),
                  Text(
                    'Checkout',
                    style: TextStyle(
                      color: _isButtonDisabled ? Colors.black : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  VerticalDivider verticalSeparator() {
    return VerticalDivider(color: Colors.grey[300], thickness: 1, width: 20);
  }
}
