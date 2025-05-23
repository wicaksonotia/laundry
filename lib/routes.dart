import 'package:get/get.dart';
import 'package:laundry/bottom_bar/bottom_screen.dart';
import 'package:laundry/page/service/service_page.dart';

class RouterClass {
  static String navigation = '/navigation';
  static String servicepage = '/servicepage';

  static List<GetPage> routes = [
    GetPage(page: () => const BottomScreen(), name: navigation),
    GetPage(page: () => const ServicePage(), name: servicepage),
  ];
}
