import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laundry/models/customer_model.dart';
import 'package:laundry/networks/api_request.dart';

class CustomerController extends GetxController {
  var customers = <DataCustomer>[].obs;
  var isLoading = true.obs;
  var dataCustomerId = 0.obs;
  var dataCustomerName = ''.obs;
  var dataCustomerPhone = ''.obs;
  var dataCustomerAddress = ''.obs;
  TextEditingController searchText = TextEditingController();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);
      var result = await RemoteDataSource.getCustomers(searchText.text);
      if (result != null) {
        customers.assignAll(result.data!);
      }
    } finally {
      isLoading(false);
    }
  }
}
