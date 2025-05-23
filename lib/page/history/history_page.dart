import 'package:flutter/material.dart';
import 'package:laundry/drawer/nav_drawer.dart' as custom_drawer;

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
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('History Page'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(child: const Text('History Page Content')),
    );
  }
}
