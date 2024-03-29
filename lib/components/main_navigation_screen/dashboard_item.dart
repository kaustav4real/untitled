import 'package:flutter/material.dart';
import 'package:untitled/components/global/next_screen.dart';
import 'package:untitled/components/main_navigation_screen/dashboard_list.dart';

class DashBoardItem extends StatelessWidget {
  final DashBoardModel child;
  const DashBoardItem({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(context, child.child);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.width * 0.4 * 0.6,
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(child.icon),
            Text(
              child.name,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
