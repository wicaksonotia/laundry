import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/models/transaction_model.dart';
import 'package:laundry/networks/api_request.dart';
import 'package:laundry/utils/colors.dart';

class HistoryController extends GetxController {
  var transactions = <DataTransaction>[].obs;
  var isLoading = true.obs;
  var startDate = DateTime.now().obs;
  var endDate = DateTime.now().obs;
  var filterBy = 'bulan'.obs;
  var initMonth = DateTime.now().month.obs;
  var initYear = DateTime.now().year.obs;
  var kios = 'laundry-stg'.obs;
  var total = 0.obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);

      TransactionModel? result;
      if (filterBy.value == 'bulan') {
        var data = {
          'monthYear': '${initMonth.value}-${initYear.value}',
          'kios': kios.value,
        };
        result = await RemoteDataSource.transactionHistoryByMonth(data);
      } else {
        var data = {
          'startDate': startDate.value,
          'endDate': endDate.value,
          'kios': kios.value,
        };
        result = await RemoteDataSource.transactionHistoryByDateRange(data);
      }
      // print(result?.data!.length);
      if (result != null) {
        transactions.assignAll(result.data!);
        total.value = transactions.fold(
          0,
          (sum, item) => sum + (item.grandTotal ?? 0),
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString(),
        icon: const Icon(Icons.error),
        snackPosition: SnackPosition.TOP,
      );
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  void updateStatus(int id, String category) async {
    try {
      isLoading(true);
      var data = {'id': id, 'category': category};
      var result = await RemoteDataSource.updateStatus(data);
      if (result) {
        fetchData();
      }
    } finally {
      isLoading(false);
    }
  }

  /// ===================================
  /// FILTER DATE, MONTH
  /// ===================================
  void nextOrPreviousMonth(bool isNext) {
    if (isNext) {
      initMonth.value++;
      if (initMonth.value > 12) {
        initMonth.value = 1;
        initYear.value++;
      }
    } else {
      initMonth.value--;
      if (initMonth.value < 1) {
        initMonth.value = 12;
        initYear.value--;
      }
    }
    // monthYear.value =
    //     "${startMonth.value.month.toString()}-${startMonth.value.year.toString()}";
    // fetchData();
  }

  void showDialogDateRangePicker() async {
    var pickedDate = await showDateRangePicker(
      context: Get.context!,
      initialDateRange: DateTimeRange(
        start: startDate.value,
        end: endDate.value,
      ),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColors.primary,
              onPrimary: Colors.white,
              outlineVariant: Colors.grey.shade200,
              // onSurfaceVariant: MyColors.green,
              outline: Colors.grey.shade300,
              secondaryContainer: Colors.green.shade50,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      startDate.value = pickedDate.start;
      endDate.value = pickedDate.end;
      fetchData();
    }
  }
}
