import 'package:flutter/material.dart';
import 'package:untitled/components/main_navigation_screen/dashboard_item.dart';
import 'package:untitled/components/main_navigation_screen/dashboard_list.dart';
import 'package:untitled/screens/view_subject_screen.dart';

import '../components/dashboard_screen/dashboard_app_bar.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 75),
          child: const DashBoardAppBar(),
        ),
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.width*0.1),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DashBoardItem(
                      child: DashBoardModel(
                        id: 1,
                        icon: Icons.book,
                        name: 'Subjects',
                        child: const DashBoard(),
                      ),
                    ),
                    DashBoardItem(
                      child: DashBoardModel(
                        id: 1,
                        icon: Icons.check_circle,
                        name: 'Take Attendance',
                        child: const DashBoard(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width*0.1),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DashBoardItem(
                      child: DashBoardModel(
                        id: 1,
                        icon: Icons.assignment_ind,
                        name: 'Assign Proxy',
                        child: const DashBoard(),
                      ),
                    ),
                    DashBoardItem(
                      child: DashBoardModel(
                        id: 1,
                        icon: Icons.bar_chart,
                        name: 'Generate Report',
                        child: const DashBoard(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
