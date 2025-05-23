import 'package:flutter/material.dart';
import 'package:laundry/utils/box_container.dart';
import 'package:laundry/utils/colors.dart';
import 'package:laundry/utils/sizes.dart';

class ServicesContainerBox extends StatefulWidget {
  const ServicesContainerBox({super.key});

  @override
  State<ServicesContainerBox> createState() => _ServicesContainerBoxState();
}

class _ServicesContainerBoxState extends State<ServicesContainerBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 120),
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: BoxContainer(
              margin: const EdgeInsets.only(right: 10, bottom: 10),
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * .85,
              height: 185,
              shadow: true,
              radius: 7,
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  servicesIcon(
                    "Cuci Basah",
                    Image.asset("assets/images/laundry.png"),
                  ),
                  servicesIcon(
                    "Cuci Kering",
                    Image.asset("assets/images/laundry.png"),
                  ),
                  servicesIcon(
                    "Cuci Lipat",
                    Image.asset("assets/images/laundry.png"),
                  ),
                  servicesIcon(
                    "Cuci Setrika",
                    Image.asset("assets/images/laundry.png"),
                  ),
                  servicesIcon(
                    "Setrika Saja",
                    Image.asset("assets/images/laundry.png"),
                  ),
                  servicesIcon(
                    "Karpet",
                    Image.asset("assets/images/carpet.png"),
                  ),
                  servicesIcon("Sepatu", Image.asset("assets/images/shoe.png")),
                  servicesIcon("Helm", Image.asset("assets/images/helmet.png")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ClipRRect servicesIcon(String text, Image image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(MySizes.cardRadiusLg),
      child: Container(
        height: 80, // Set your desired height here
        color: MyColors.notionBgPurple,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: image.image, height: 40, width: 40),
            const SizedBox(height: 5),
            Text(
              text,
              style: const TextStyle(
                fontSize: MySizes.fontSizeSm,
                color: MyColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
