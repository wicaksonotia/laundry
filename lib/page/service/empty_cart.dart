import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:laundry/utils/sizes.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/empty_cart.png', height: 100),
          const Gap(16),
          const Text(
            'Your cart is empty',
            style: TextStyle(fontSize: MySizes.fontSizeXl, color: Colors.black),
          ),
          const Gap(16),
          const Text(
            'Looks like you haven\'t add any item to your cart yet!',
            style: TextStyle(fontSize: MySizes.fontSizeMd, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
