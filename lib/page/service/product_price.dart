import 'package:flutter/material.dart';
import 'package:laundry/utils/colors.dart';
import 'package:laundry/utils/currency.dart';
import 'package:laundry/utils/sizes.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    super.key,
    required this.dataPrice,
    required this.dataSatuan,
  });

  final int dataPrice;
  final String dataSatuan;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: CurrencyFormat.convertToIdr(dataPrice, 0),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MySizes.fontSizeLg,
              color: MyColors.primary,
            ),
          ),
          TextSpan(
            text: ' / $dataSatuan',
            style: const TextStyle(
              fontSize: MySizes.fontSizeSm,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
