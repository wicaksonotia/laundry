import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laundry/controllers/history_controller.dart';
import 'package:laundry/utils/colors.dart';

class FilterDateRange extends StatefulWidget {
  const FilterDateRange({super.key});

  @override
  State<FilterDateRange> createState() => _FilterDateRangeState();
}

class _FilterDateRangeState extends State<FilterDateRange> {
  final HistoryController _historyController = Get.find<HistoryController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.date_range, color: MyColors.primary),
        const SizedBox(width: 10),
        Obx(
          () => GestureDetector(
            onTap: () {
              _historyController.showDialogDateRangePicker();
            },
            child: Text(
              '${DateFormat('dd MMM yyyy').format(_historyController.startDate.value)} - ${DateFormat('dd MMM yyyy').format(_historyController.endDate.value)}',
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
