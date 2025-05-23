import 'package:flutter/material.dart';
import 'package:laundry/utils/colors.dart';

class NavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;

  const NavBar({super.key, required this.pageIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: MyColors.notionBgGrey,
      child: Row(
        children: [
          navItem(Icons.home_outlined, pageIndex == 0, () => onTap(0), "Home"),
          navItem(
            Icons.message_outlined,
            pageIndex == 1,
            () => onTap(1),
            "History",
          ),
          const SizedBox(width: 80),
          navItem(
            Icons.notifications_none_outlined,
            pageIndex == 2,
            () => onTap(2),
            "Notifications",
          ),
          navItem(
            Icons.person_outline,
            pageIndex == 3,
            () => onTap(3),
            "Profile",
          ),
        ],
      ),
    );
  }

  Widget navItem(
    IconData icon,
    bool selected,
    Function()? onTap,
    String label,
  ) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: selected ? MyColors.primary : Colors.grey),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: selected ? MyColors.primary : Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
