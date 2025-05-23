import 'package:laundry/models/service_model.dart';
import 'package:get/get.dart';
import 'package:laundry/networks/api_request.dart';

class ServiceController extends GetxController {
  var services = <ServiceModel>[].obs;
  var category = 'Self Service'.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchProduct();
    super.onInit();
  }

  void fetchProduct() async {
    try {
      isLoading(true);
      var result = await RemoteDataSource.getServices(category.value);
      if (result != null) {
        services.assignAll(result);
      }
    } finally {
      isLoading(false);
    }
  }
}
