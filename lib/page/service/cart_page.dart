import 'package:laundry/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:laundry/utils/currency.dart';
import 'package:laundry/utils/sizes.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartController cartController;

  @override
  void initState() {
    super.initState();
    cartController = Get.find<CartController>();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: .25,
      maxChildSize: .5,
      minChildSize: .2,
      builder: (context, scrollController) {
        return Column(
          children: [
            if (cartController.cartList.isEmpty)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/empty_cart.png', height: 100),
                    const Gap(16),
                    const Text(
                      'Your cart is empty',
                      style: TextStyle(
                        fontSize: MySizes.fontSizeXl,
                        color: Colors.black,
                      ),
                    ),
                    const Gap(16),
                    const Text(
                      'Looks like you haven\'t add any item to your cart yet!',
                      style: TextStyle(
                        fontSize: MySizes.fontSizeMd,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: cartController.cartList.length,
                  itemBuilder: (context, index) {
                    final cart = cartController.cartList[index];
                    return Slidable(
                      key: Key(cart.serviceModel.id.toString()),
                      endActionPane: ActionPane(
                        extentRatio: 0.25,
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              setState(() {
                                cartController.removeProduct(cart.serviceModel);
                                if (cartController.cartList.isEmpty) {
                                  Navigator.pop(context);
                                }
                              });
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          cart.serviceModel.serviceName!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: MySizes.fontSizeLg,
                          ),
                        ),
                        subtitle: Text(
                          'total Harga : Rp ${CurrencyFormat.convertToIdr(cart.serviceModel.price! * cart.quantity, 0)}',
                        ),
                        trailing: Text(
                          cart.quantity.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: MySizes.fontSizeLg,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
