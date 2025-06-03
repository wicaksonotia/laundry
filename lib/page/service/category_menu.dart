import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:laundry/controllers/category_controller.dart';
import 'package:laundry/controllers/service_controller.dart';
import 'package:laundry/utils/colors.dart';

class CategoryMenu extends StatefulWidget {
  const CategoryMenu({super.key});

  @override
  State<CategoryMenu> createState() => _CategoryMenuState();
}

class _CategoryMenuState extends State<CategoryMenu> {
  final ServiceController _serviceController = Get.find<ServiceController>();
  final CategoryController _categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_categoryController.categories.isEmpty) {
        return Container(
          height: 40,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return Container(
                width: 100,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey.shade300,
                      Colors.grey.shade100,
                      Colors.grey.shade300,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: ShaderMask(
                  shaderCallback:
                      (bounds) => LinearGradient(
                        colors: [
                          Colors.grey.shade300,
                          Colors.grey.shade100,
                          Colors.grey.shade300,
                        ],
                        stops: [0.1, 0.5, 0.9],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        tileMode: TileMode.mirror,
                      ).createShader(bounds),
                  blendMode: BlendMode.srcATop,
                  child: Container(color: Colors.white.withOpacity(0.5)),
                ),
              );
            },
          ),
        );
      } else {
        return CupertinoSlidingSegmentedControl(
          backgroundColor: Colors.transparent,
          thumbColor: MyColors.primary,
          padding: const EdgeInsets.all(5),
          groupValue: _serviceController.category.value,
          children: Map.fromEntries(
            _categoryController.categories.map(
              (item) => MapEntry(
                item.name ?? "",
                Text(
                  item.name ?? "",
                  style: TextStyle(
                    color:
                        _serviceController.category.value == item.name
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
              ),
            ),
          ),
          onValueChanged: (value) {
            setState(() {
              _serviceController.category.value = value!;
              _serviceController.fetchProduct();
            });
          },
        );
      }
    });
  }
}
