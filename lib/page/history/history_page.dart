import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/controllers/history_controller.dart';
import 'package:laundry/drawer/nav_drawer.dart' as custom_drawer;
import 'package:laundry/page/history/footer.dart';
import 'package:laundry/page/history/history_list.dart';
// import 'package:laundry/page/history/stepper_page.dart';
import 'package:laundry/utils/colors.dart';
import 'package:laundry/utils/sizes.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final HistoryController _historyController = Get.put(HistoryController());
  Future<void> _refresh() async {
    _historyController.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FooterReport(historyController: _historyController),
      drawer: custom_drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text(
          'History Page',
          style: TextStyle(
            fontSize: MySizes.fontSizeLg,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Container(
          color: MyColors.notionBgGrey,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            children: [
              Expanded(
                child: HistoryList(historyController: _historyController),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
