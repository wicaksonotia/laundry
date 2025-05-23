import 'package:get/get.dart';
import 'package:laundry/controllers/cart_controller.dart';
import 'package:laundry/controllers/category_controller.dart';
import 'package:laundry/controllers/login_controller.dart';
import 'package:laundry/controllers/service_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() async {
    // Get.put<LoginController>(LoginController());
    Get.put<ServiceController>(ServiceController());
    Get.put<CategoryController>(CategoryController());
    Get.put<CartController>(CartController());
    // Get.lazyPut<CategoryController>(() => CategoryController());
    // Get.lazyPut<ServiceController>(() => ServiceController());
    // Get.lazyPut<CartController>(() => CartController());
  }
}
