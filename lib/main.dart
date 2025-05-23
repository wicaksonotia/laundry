import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/initial_binding.dart';
import 'package:laundry/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Get.put(prefs);

  // await Future.delayed(const Duration(seconds: 2));
  // FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      getPages: RouterClass.routes,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      debugShowCheckedModeBanner: false,
      initialRoute: RouterClass.servicePage,
    );
  }
}
