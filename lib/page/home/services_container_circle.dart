import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:laundry/utils/box_container.dart';
import 'package:laundry/utils/colors.dart';

class ServicesContainerCircle extends StatefulWidget {
  const ServicesContainerCircle({super.key});

  @override
  State<ServicesContainerCircle> createState() =>
      _ServicesContainerCircleState();
}

class _ServicesContainerCircleState extends State<ServicesContainerCircle> {
  List<Map<String, dynamic>> services = [
    {
      "name": "Cuci Basah",
      "icon": "cuci_basah.png",
      "color": MyColors.notionBgBlue,
    },
    {
      "name": "Cuci Kering",
      "icon": "cuci_kering.png",
      "color": MyColors.notionBgPurple,
    },
    {
      "name": "Cuci Lipat",
      "icon": "cuci_lipat.png",
      "color": MyColors.notionBgGreen,
    },
    {
      "name": "Cuci Setrika",
      "icon": "cuci_setrika.png",
      "color": MyColors.notionBgOrange,
    },
    {
      "name": "Setrika Saja",
      "icon": "setrika_saja.png",
      "color": MyColors.notionBgPink,
    },
    {"name": "Karpet", "icon": "carpet.png", "color": MyColors.notionBgYellow},
    {"name": "Sepatu", "icon": "shoe.png", "color": MyColors.notionBgRed},
    {"name": "Helm", "icon": "helmet.png", "color": MyColors.notionBgGrey},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: BoxContainer(
        margin: const EdgeInsets.only(right: 10, bottom: 10),
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * .85,
        height: 200,
        shadow: true,
        radius: 7,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
            mainAxisExtent: 90,
          ),
          itemCount: 8,
          itemBuilder: (context, index) {
            return servicesIcon(
              services[index]['name'],
              services[index]['icon'],
              services[index]['color'],
            );
          },
        ),
      ),
    );
  }

  Widget servicesIcon(String text, String image, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset('assets/images/$image'),
          ),
        ),
        const Gap(5),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
