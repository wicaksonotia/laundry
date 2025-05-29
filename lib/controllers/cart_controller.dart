import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/controllers/print_nota_controller.dart';
import 'package:laundry/models/cart_model.dart';
import 'package:laundry/models/service_model.dart';
import 'package:laundry/networks/api_request.dart';

class CartController extends GetxController {
  final PrintNotaController _printNotaController = Get.put(
    PrintNotaController(),
  );
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerPhoneController = TextEditingController();
  TextEditingController customerAddressController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  List<CartModel> cartList = <CartModel>[].obs;
  var isLoading = false.obs;
  var numberOfItems = 1.obs;
  RxDouble totalPrice = 0.0.obs;
  RxInt totalAllQuantity = 0.obs;
  var paymentStatus = false.obs;

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

  double getProductQuantity(ServiceModel dataProduct) {
    var index = cartList.indexWhere(
      (element) => element.serviceModel.id == dataProduct.id,
    );
    if (index >= 0) {
      return cartList[index].quantity;
    } else {
      return 0;
    }
  }

  void saveCart(discount) async {
    try {
      isLoading(true);
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      var kios = 'laundry-stg';
      var dataDetailTransaction =
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
      var dataTransaction = {
        'kios': kios,
        'discount': discount,
        'payment': paymentStatus.value,
        'customer_name': customerNameController.text,
        'customer_phone': customerPhoneController.text,
        'customer_address': customerAddressController.text,
      };
      var resultSave = await RemoteDataSource.saveTransaction(
        dataTransaction,
        dataDetailTransaction,
      );
      if (resultSave) {
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
        paymentStatus.value = false;
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
}
