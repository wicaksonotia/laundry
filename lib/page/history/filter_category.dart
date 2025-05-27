import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:laundry/controllers/history_controller.dart';
import 'package:laundry/page/history/filter_date_range.dart';
import 'package:laundry/page/history/filter_month.dart';
import 'package:laundry/utils/colors.dart';
import 'package:laundry/utils/lists.dart';

class FilterCategory extends StatefulWidget {
  const FilterCategory({super.key});

  @override
  State<FilterCategory> createState() => _FilterCategoryState();
}

class _FilterCategoryState extends State<FilterCategory> {
  final HistoryController _historyController = Get.find<HistoryController>();
  int? groupValue = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.grey[300]!),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: List.generate(
              filterKategori.length,
              (index) => Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      groupValue = index;
                    });
                    _historyController.filterBy.value =
                        filterKategori[index]['value']!;
                    // _historyController.fetchData();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(width: 0.5, color: Colors.grey[300]!),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Center(
                      child: Text(
                        filterKategori[index]['nama']!,
                        style: TextStyle(
                          color:
                              groupValue == index
                                  ? MyColors.primary
                                  : Colors.black,
                          fontWeight:
                              groupValue == index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // NEXT AND PREVIOUS MONTH YEAR
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: context.height * 0.05,
            child: Obx(
              () =>
                  _historyController.filterBy.value == 'bulan'
                      ? const FilterMonth()
                      : const FilterDateRange(),
            ),
          ),
          const Gap(5),
        ],
      ),
    );
  }
}
