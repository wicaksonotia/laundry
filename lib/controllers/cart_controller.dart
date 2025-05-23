import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:laundry/controllers/print_nota_controller.dart';
import 'package:laundry/models/cart_model.dart';
import 'package:laundry/models/service_model.dart';
import 'package:laundry/networks/api_request.dart';
import 'package:laundry/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  final PrintNotaController _printNotaController = Get.put(
    PrintNotaController(),
  );
  List<CartModel> cartList = <CartModel>[].obs;
  var isLoading = false.obs;
  var numberOfItems = 1.obs;
  RxDouble totalPrice = 0.0.obs;
  RxInt totalAllQuantity = 0.obs;

  void incrementProductQuantity(ServiceModel dataProduct) {
    if (cartList.where((element) => element.id == dataProduct.id).isNotEmpty) {
      var index = cartList.indexWhere(
        (element) => element.id == dataProduct.id,
      );
      cartList[index].quantity++;
    } else {
      cartList.add(
        CartModel(serviceModel: dataProduct, id: dataProduct.id!, quantity: 1),
      );
    }
    totalAllQuantity.value = cartList.length;
    totalPrice.value += dataProduct.price!;
    update();
  }

  void decrementProductQuantity(ServiceModel dataProduct) {
    var index = cartList.indexWhere((element) => element.id == dataProduct.id);
    if (index >= 0) {
      if (cartList[index].quantity > 0) {
        cartList[index].quantity--;
        // totalAllQuantity.value--;
        totalPrice.value -= dataProduct.price!;
      } else {
        cartList.removeAt(index);
      }
    }
    totalAllQuantity.value = cartList.length;
    update();
  }

  void removeProduct(ServiceModel dataProduct) {
    var index = cartList.indexWhere((element) => element.id == dataProduct.id);
    if (index >= 0) {
      // totalAllQuantity.value -= cartList[index].quantity;
      totalPrice.value -= dataProduct.price! * cartList[index].quantity;
      cartList.removeAt(index);
    }
    totalAllQuantity.value = cartList.length;
    update();
  }

  getProductQuantity(ServiceModel dataProduct) {
    var index = cartList.indexWhere(
      (element) => element.serviceModel.id == dataProduct.id,
    );
    if (index >= 0) {
      return cartList[index].quantity;
    } else {
      return 0;
    }
  }

  void showBottomSheet() async {
    TextEditingController discountController = TextEditingController();
    int discount = 0;
    if (cartList.isNotEmpty) {
      await Get.bottomSheet(
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter Discount",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
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
                controller: discountController,
                decoration: const InputDecoration(
                  labelText: "Discount",
                  border: OutlineInputBorder(),
                ),
              ),
              const Gap(10),
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
                        discount =
                            discountController.text.isNotEmpty
                                ? int.parse(
                                  discountController.text.replaceAll(
                                    RegExp('[^0-9]'),
                                    '',
                                  ),
                                )
                                : 0;
                        saveCart(discount);
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
              const Gap(10),
            ],
          ),
        ),
      );
    } else {
      Get.snackbar(
        'Notification',
        'Your cart is empty',
        icon: const Icon(Icons.error),
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
  }

  void saveCart(discount) async {
    try {
      isLoading(true);
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      var kios = 'laundry-stg';
      var payload =
          cartList.map((cartItem) {
            return {
              'id_service': cartItem.id,
              'service_name': cartItem.serviceModel.serviceName.toString(),
              'quantity': cartItem.quantity,
              'unit_price': cartItem.serviceModel.price,
              // 'kios': prefs.getString('username'),
              'kios': kios,
            };
          }).toList();
      var resultSave = await RemoteDataSource.saveDetailTransaction(payload);
      if (resultSave) {
        await RemoteDataSource.saveTransaction(
          // prefs.getString('username')!,
          kios,
          discount,
        );
        // NOTIF SAVE SUCCESS
        Get.snackbar(
          'Notification',
          'Data saved successfully',
          icon: const Icon(Icons.check),
          snackPosition: SnackPosition.TOP,
        );
        // PRINT TRANSACTION
        // _printNotaController.printTransaction(
        //   int.parse(prefs.getString('numerator')!),
        //   prefs.getString('username')!,
        // );
        // CLEAR TRANSACTION
        cartList.clear();
        totalAllQuantity = 0.obs;
        totalPrice.value = 0;
        update();
      }
    } catch (e) {
      Get.snackbar(
        'Notification',
        'Failed to save transaction: ${e.toString()}',
        icon: const Icon(Icons.error),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading(false);
    }
  }

  void clearCart() {
    cartList.clear();
    totalAllQuantity.value = 0;
    totalPrice.value = 0;
    update();
  }

  void setProductQuantity(ServiceModel dataProduct, double quantity) {
    if (quantity > 0) {
      var index = cartList.indexWhere(
        (element) => element.id == dataProduct.id,
      );
      if (index >= 0) {
        // totalAllQuantity.value -= cartList[index].quantity;
        totalPrice.value -= dataProduct.price! * cartList[index].quantity;
        cartList[index].quantity = quantity;
      } else {
        cartList.add(
          CartModel(
            serviceModel: dataProduct,
            id: dataProduct.id!,
            quantity: quantity,
          ),
        );
      }
      // totalAllQuantity.value += quantity;
      totalPrice.value += dataProduct.price! * quantity;
    } else {
      cartList.removeWhere((element) => element.id == dataProduct.id);
      // totalAllQuantity.value -= quantity;
      totalPrice.value -= dataProduct.price! * quantity;
    }
    totalAllQuantity.value = cartList.length;
    update(); // or refresh your observable if using Rx
  }
}
