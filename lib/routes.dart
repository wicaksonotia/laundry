import 'package:get/get.dart';
import 'package:laundry/bottom_bar/bottom_screen.dart';
import 'package:laundry/page/bluetooth_setting_page.dart';
import 'package:laundry/page/history/history_page.dart';
import 'package:laundry/page/service/service_page.dart';

class RouterClass {
  static String navigation = '/navigation';
  static String servicePage = '/service_page';
  static String historyPage = '/history_page';
  static String bluetoothSettingPage = "/bluetooth_setting_page";

  static List<GetPage> routes = [
    GetPage(page: () => const BottomScreen(), name: navigation),
    GetPage(page: () => const ServicePage(), name: servicePage),
    GetPage(page: () => const HistoryPage(), name: historyPage),
    GetPage(
      page: () => const BluetoothSettingPage(),
      name: bluetoothSettingPage,
    ),
  ];
}
