import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/controllers/history_controller.dart';
import 'package:laundry/drawer/nav_drawer.dart' as custom_drawer;
import 'package:laundry/page/history/footer.dart';
import 'package:laundry/page/history/history_list.dart';
import 'package:laundry/page/history/sidebar_filter.dart';

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

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FooterReport(historyController: _historyController),
      drawer: custom_drawer.NavigationDrawer(),
      appBar: AppBar(
        title: AnimatedSearchBar(
          label: 'Cari Nama ...',
          controller: _controller,
          labelStyle: const TextStyle(fontSize: 16),
          searchStyle: const TextStyle(color: Colors.grey),
          cursorColor: Colors.grey,
          textInputAction: TextInputAction.done,
          autoFocus: false,
          searchDecoration: InputDecoration(
            hintText: 'Search',
            alignLabelWithHint: true,
            // fillColor: Colors.blue,
            // focusColor: Colors.green,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            border: InputBorder.none,
          ),
          onFieldSubmitted: (value) {
            _historyController.searchText.value = value;
            _historyController.fetchData();
          },
          onClose: () {
            _historyController.searchText.value = '';
            _historyController.fetchData();
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _refresh,
            child: Container(
              color: Colors.grey.shade50,
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
          // Position SidebarFilter to the right
          SidebarFilter(historyController: _historyController),
        ],
      ),
    );
  }
}
