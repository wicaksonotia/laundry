import 'package:get/get.dart';
import 'package:laundry/models/category_model.dart';
import 'package:laundry/networks/api_request.dart';

class CategoryController extends GetxController {
  var categories = <CategoryModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);
      var result = await RemoteDataSource.getCategories();
      if (result != null) {
        categories.assignAll(result);
      }
    } finally {
      isLoading(false);
    }
  }
}
