import 'package:get/get.dart';
import 'package:laundry/models/transaction_model.dart';
import 'package:laundry/networks/api_request.dart';

class HistoryController extends GetxController {
  var transactions = <TransactionModel>[].obs;
  var isLoading = true.obs;
  var startDate = DateTime.now().obs;
  var endDate = DateTime.now().obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);
      var result = await RemoteDataSource.getListTransactions(
        startDate.value,
        endDate.value,
      );
      if (result != null) {
        transactions.assignAll(result);
      }
    } finally {
      isLoading(false);
    }
  }
}
