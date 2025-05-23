import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/controllers/login_controller.dart';
import 'package:laundry/controllers/service_controller.dart';
import 'package:laundry/page/service/category_menu.dart';
import 'package:laundry/page/service/footer.dart';
import 'package:laundry/page/service/service_list_view.dart';
import 'package:laundry/utils/box_container.dart';
import 'package:laundry/utils/colors.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    final ServiceController _serviceController = Get.find<ServiceController>();
    // final LoginController loginController = Get.find<LoginController>();

    return Scaffold(
      backgroundColor: MyColors.notionBgGrey,
      bottomNavigationBar: const FooterService(),
      body: RefreshIndicator(
        onRefresh: () async {
          _serviceController.fetchProduct();
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              actions: [
                PopupMenuButton(
                  color: Colors.white,
                  icon: const Icon(Icons.more_vert, color: MyColors.primary),
                  onSelected: (dynamic value) {},
                  itemBuilder:
                      (BuildContext context) => <PopupMenuEntry>[
                        PopupMenuItem(
                          child: ListTile(
                            leading: const Icon(Icons.edit_document),
                            title: const Text('Report'),
                            onTap: () {
                              Get.back();
                              Get.toNamed('/reporttransaction');
                            },
                          ),
                        ),
                        const PopupMenuDivider(),
                        PopupMenuItem(
                          child: ListTile(
                            leading: const Icon(Icons.bluetooth_searching),
                            title: const Text('Setting Bluetooth'),
                            onTap: () {
                              Get.back();
                              Get.toNamed('/bluetooth_setting');
                            },
                          ),
                        ),
                        const PopupMenuItem(
                          child: ListTile(
                            leading: Icon(Icons.settings),
                            title: Text('Settings'),
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            leading: const Icon(Icons.logout),
                            title: const Text('Logout'),
                            onTap: () {
                              // loginController.logout();
                            },
                          ),
                        ),
                      ],
                ),
              ],
              backgroundColor: MyColors.primary,
              flexibleSpace: const FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Image(
                  image: AssetImage('assets/images/header.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              pinned: true,
              expandedHeight: 130,
              collapsedHeight: 50,
              toolbarHeight: 30,
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                const BoxContainer(
                  shadow: true,
                  radius: 0,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: CategoryMenu(),
                ),
              ),
              pinned: true,
            ),
            SliverToBoxAdapter(child: ServiceListView()),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget _widget;

  _SliverAppBarDelegate(this._widget);

  @override
  double get minExtent => 40.0;

  @override
  double get maxExtent => 40.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return _widget;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
