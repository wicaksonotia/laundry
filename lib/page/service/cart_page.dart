import 'package:laundry/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:laundry/page/service/empty_cart.dart';
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
              const EmptyCart()
            else
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  itemCount: cartController.cartList.length,
                  separatorBuilder:
                      (context, index) => Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey.shade300,
                      ),
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
                                  Future.delayed(
                                    const Duration(seconds: 1),
                                  ).then((_) {
                                    Get.back();
                                  });
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
                            fontSize: MySizes.fontSizeMd,
                          ),
                        ),
                        subtitle: Text(
                          'total Harga : Rp ${CurrencyFormat.convertToIdr(cart.serviceModel.price! * cart.quantity, 0)}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: MySizes.fontSizeSm,
                          ),
                        ),
                        trailing: Text(
                          "${cart.quantity} ${cart.serviceModel.satuan!}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: MySizes.fontSizeMd,
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
