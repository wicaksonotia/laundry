import 'package:flutter/material.dart';
import 'package:laundry/bottom_bar/nav_bar.dart';
import 'package:laundry/bottom_bar/nav_model.dart';
import 'package:laundry/page/home/home_page.dart';
import 'package:laundry/utils/colors.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({super.key});

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  final homeNavKey = GlobalKey<NavigatorState>();
  final searchNavKey = GlobalKey<NavigatorState>();
  final notificationNavKey = GlobalKey<NavigatorState>();
  final profileNavKey = GlobalKey<NavigatorState>();
  int selectedTab = 0;
  List<NavModel> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      NavModel(page: const HomePage(), navKey: homeNavKey),
      NavModel(page: const HomePage(), navKey: searchNavKey),
      NavModel(page: const HomePage(), navKey: notificationNavKey),
      NavModel(page: const HomePage(), navKey: profileNavKey),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Removed unsupported onPopInvokedWithResult property
      child: Scaffold(
        body: IndexedStack(
          index: selectedTab,
          children:
              items
                  .map(
                    (page) => Navigator(
                      key: page.navKey,
                      onGenerateInitialRoutes: (navigator, initialRoute) {
                        return [
                          MaterialPageRoute(builder: (context) => page.page),
                        ];
                      },
                    ),
                  )
                  .toList(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: const EdgeInsets.only(top: 10),
          height: 64,
          width: 64,
          child: FloatingActionButton(
            backgroundColor: MyColors.primary,
            elevation: 0,
            onPressed: () => debugPrint("Add Button pressed"),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 5, color: Colors.white),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 30),
          ),
        ),
        bottomNavigationBar: NavBar(
          pageIndex: selectedTab,
          onTap: (index) {
            if (index == selectedTab) {
              items[index].navKey.currentState?.popUntil(
                (route) => route.isFirst,
              );
            } else {
              setState(() {
                selectedTab = index;
              });
            }
          },
        ),
      ),
    );
  }
}
