import 'package:flutter/material.dart';
import 'package:laundry/page/home/search_bar.dart';
// import 'package:laundry/page/home/services_container_box.dart';
import 'package:laundry/page/home/services_container_circle.dart';
import 'package:laundry/utils/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: [
            // HEADER
            Stack(
              children: [
                // BACKGROUND HEADER
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [MyColors.primary, MyColors.secondary],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                ),

                Positioned(
                  top: -100,
                  left: -50,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white.withAlpha((0.2 * 255).toInt()),
                    ),
                  ),
                ),

                Positioned(
                  top: 50,
                  right: -60,
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white.withAlpha((0.2 * 255).toInt()),
                    ),
                  ),
                ),

                Positioned(
                  top: 70,
                  right: -40,
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: MyColors.primary,
                    ),
                  ),
                ),

                // USER PROFILE
                Positioned(
                  top: 50,
                  left: 30,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/man.jpg', // Replace with your image path
                            fit: BoxFit.fitHeight,
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Hello, Tia Wicaksono", // Replace with dynamic name if needed
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Cab. Bangsongan, Kediri",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 170),
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50),
                    ),
                  ),
                ),

                // SEARCH BAR
                const SearchBarContainer(),
              ],
            ),
            // MENU
            const ServicesContainerCircle(),

            // const SeeAllContainer(
            //   header: "Special Offer",
            //   subHeader: "Easy with promo code",
            //   buttonLihatSemua: true,
            // ),
          ],
        ),
      ),
    );
  }
}
