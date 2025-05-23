import 'package:flutter/material.dart';
import 'package:laundry/drawer/nav_drawer.dart' as custom_drawer;
import 'package:laundry/utils/colors.dart';
import 'package:laundry/utils/sizes.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(child: const Text('History Page Content')),
    );
  }
}
