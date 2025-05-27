import 'package:flutter/material.dart';
import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laundry/controllers/history_controller.dart';
import 'package:laundry/utils/colors.dart';

class FilterMonth extends StatefulWidget {
  const FilterMonth({super.key});

  @override
  State<FilterMonth> createState() => _FilterMonthState();
}

class _FilterMonthState extends State<FilterMonth> {
  final HistoryController _historyController = Get.find<HistoryController>();
  int month = DateTime.now().month;
  int year = DateTime.now().year;
  int enableMonth = DateTime.now().month;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => _historyController.nextOrPreviousMonth(false),
        ),
        Expanded(
          child: Center(
            child: Obx(
              () => GestureDetector(
                onTap: () async {
                  showMonthPicker(
                    context,
                    onSelected: (month, year) {
                      month = month;
                      year = year;
                      _historyController.initMonth.value = month;
                      _historyController.initYear.value = year;
                    },
                    initialSelectedMonth: _historyController.initMonth.value,
                    initialSelectedYear: _historyController.initYear.value,
                    firstEnabledMonth: 1,
                    lastEnabledMonth: enableMonth,
                    firstYear: _historyController.initYear.value,
                    lastYear: _historyController.initYear.value,
                    selectButtonText: 'OK',
                    cancelButtonText: 'Cancel',
                    highlightColor: MyColors.primary,
                    textColor: Colors.black,
                    contentBackgroundColor: Colors.white,
                    dialogBackgroundColor: Colors.grey[200],
                  );
                },
                child: Text(
                  "${DateFormat('MMMM').format(DateTime(0, _historyController.initMonth.value))} ${_historyController.initYear.value}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () {
            if (_historyController.initYear.value < DateTime.now().year ||
                (_historyController.initYear.value == DateTime.now().year &&
                    _historyController.initMonth.value <
                        DateTime.now().month)) {
              _historyController.nextOrPreviousMonth(true);
              month = _historyController.initMonth.value;
              year = _historyController.initYear.value;
            }
          },
        ),
      ],
    );
  }
}
