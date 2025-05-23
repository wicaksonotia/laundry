import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:laundry/controllers/cart_controller.dart';
import 'package:laundry/models/service_model.dart';
import 'package:laundry/utils/colors.dart';

class IncrementAndDecrement extends StatefulWidget {
  const IncrementAndDecrement({super.key, required this.dataProduct});

  final ServiceModel dataProduct;

  @override
  _IncrementAndDecrementState createState() => _IncrementAndDecrementState();
}

class _IncrementAndDecrementState extends State<IncrementAndDecrement> {
  final CartController _cartController = Get.find<CartController>();
  var quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color:
                  MyColors
                      .notionBgRed, // Set your desired background color here
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: 10, // desired size
              onPressed: () {
                _cartController.decrementProductQuantity(widget.dataProduct);
                setState(() {
                  quantity--;
                  if (quantity < 1) {
                    _cartController.removeProduct(widget.dataProduct);
                  }
                });
              },
              icon: const Icon(Icons.remove, color: Colors.black),
            ),
          ),
          SizedBox(
            width: 50,
            child: Center(
              child: TextField(
                controller: TextEditingController(
                  text:
                      '${_cartController.getProductQuantity(widget.dataProduct)}',
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                onSubmitted: (value) {
                  double? newQuantity = double.tryParse(value);
                  if (newQuantity != null && newQuantity > 0) {
                    _cartController.setProductQuantity(
                      widget.dataProduct,
                      newQuantity,
                    );
                    setState(() {});
                  }
                },
              ),
            ),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color:
                  MyColors
                      .notionBgGreen, // Set your desired background color here
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: 10, // desired size
              onPressed: () {
                _cartController.incrementProductQuantity(widget.dataProduct);
                setState(() {
                  quantity++;
                });
              },
              icon: const Icon(Icons.add, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
