import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:laundry/page/history/filter_date_range.dart';
import 'package:laundry/page/history/filter_month.dart';
import 'package:laundry/utils/colors.dart';
import 'package:laundry/utils/lists.dart';
import 'package:laundry/utils/sizes.dart';

class SidebarFilter extends StatefulWidget {
  final dynamic historyController;

  const SidebarFilter({super.key, required this.historyController});

  @override
  State<SidebarFilter> createState() => _SidebarFilterState();
}

class _SidebarFilterState extends State<SidebarFilter>
    with SingleTickerProviderStateMixin<SidebarFilter> {
  final _animationDuration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Obx(
      () => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop && widget.historyController.isSideBarOpen.value) {
            widget.historyController.isSideBarOpen.value = false;
          }
        },
        child: AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          right:
              widget.historyController.isSideBarOpen.value ? 0 : -screenWidth,
          bottom: 0,
          width: screenWidth * 0.7,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: MySizes.iconSm,
                      icon: const Icon(Icons.close),
                      onPressed:
                          () =>
                              widget.historyController.isSideBarOpen.value =
                                  false,
                    ),
                    Expanded(
                      child: Text(
                        'Filter',
                        style: TextStyle(
                          fontSize: MySizes.fontSizeLg,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                DividerLine(label: "Berdasarkan Tanggal"),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Obx(
                    () => ChipsChoice.single(
                      wrapped: true,
                      padding: EdgeInsets.zero,
                      value: widget.historyController.filterBy.value,
                      onChanged:
                          (val) =>
                              widget.historyController.filterBy.value = val,
                      choiceItems:
                          C2Choice.listFrom<String, Map<String, dynamic>>(
                            source: filterKategori,
                            value: (i, v) => v['value'] as String,
                            label: (i, v) => v['nama'] as String,
                          ),
                      choiceStyle: C2ChipStyle.filled(
                        foregroundStyle: const TextStyle(
                          fontSize: MySizes.fontSizeSm,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        color: MyColors.notionBgGrey,
                        selectedStyle: const C2ChipStyle(
                          backgroundColor: MyColors.primary,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(5),
                Container(
                  color: Colors.white,
                  height: context.height * 0.05,
                  child: Obx(
                    () =>
                        widget.historyController.filterBy.value == 'bulan'
                            ? const FilterMonth()
                            : const FilterDateRange(),
                  ),
                ),
                DividerLine(label: "Status"),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Obx(
                    () => ChipsChoice.single(
                      wrapped: true,
                      padding: EdgeInsets.zero,
                      value: widget.historyController.filterStatus.value,
                      onChanged: (val) {
                        widget.historyController.filterStatus.value = val;
                        widget.historyController.fetchData();
                      },
                      choiceItems:
                          C2Choice.listFrom<String, Map<String, dynamic>>(
                            source: filterStatus,
                            value: (i, v) => v['value'] as String,
                            label: (i, v) => v['nama'] as String,
                          ),
                      choiceStyle: C2ChipStyle.filled(
                        foregroundStyle: const TextStyle(
                          fontSize: MySizes.fontSizeSm,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        color: MyColors.notionBgGrey,
                        selectedStyle: const C2ChipStyle(
                          backgroundColor: MyColors.primary,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DividerLine extends StatelessWidget {
  final String label;
  const DividerLine({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: Colors.grey.shade300, thickness: 0.5),
        Gap(8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: MySizes.fontSizeMd,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        Gap(12),
      ],
    );
  }
}
