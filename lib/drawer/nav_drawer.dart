import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:laundry/routes.dart';
import 'package:laundry/utils/colors.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            buildDrawerHeader(),
            Gap(20),
            buildDrawerItem(
              icon: Icons.photo,
              text: "Services",
              onTap: () => Get.toNamed(RouterClass.servicePage),
              tileColor: Colors.black,
              textIconColor:
                  Get.currentRoute == RouterClass.servicePage
                      ? MyColors.primary
                      : Colors.black,
            ),
            buildDrawerItem(
              icon: Icons.video_call,
              text: "Histories",
              onTap: () => Get.toNamed(RouterClass.historyPage),
              tileColor: Colors.black,
              textIconColor:
                  Get.currentRoute == RouterClass.historyPage
                      ? MyColors.primary
                      : Colors.black,
            ),
            Divider(color: Colors.grey.shade300),
            buildDrawerItem(
              icon: Icons.bluetooth,
              text: "Setting Bluetooth",
              onTap: () => Get.toNamed(RouterClass.historyPage),
              tileColor: Colors.black,
              textIconColor: Colors.black,
            ),
            buildDrawerItem(
              icon: Icons.logout,
              text: "Log Out",
              onTap: () => Get.toNamed(RouterClass.historyPage),
              tileColor: Colors.black,
              textIconColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: MyColors.primary),
      accountName: Text("Tia Wicaksono"),
      accountEmail: Text("wicaksono.tia@gmail.com"),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage('assets/images/man.jpg'),
      ),
      currentAccountPictureSize: Size.square(72),
      // otherAccountsPictures: [
      //   CircleAvatar(backgroundColor: Colors.white, child: Text("TW")),
      // ],
      otherAccountsPicturesSize: Size.square(50),
    );
  }

  Widget buildDrawerItem({
    required String text,
    required IconData icon,
    required Color textIconColor,
    required Color? tileColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: textIconColor),
      title: Text(text, style: TextStyle(color: textIconColor)),
      tileColor: tileColor,
      onTap: onTap,
    );
  }
}
