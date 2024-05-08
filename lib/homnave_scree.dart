// ignore_for_file: prefer_const_constructors


import 'package:demo/dashboard_screen.dart';
import 'package:demo/report_screen.dart';
import 'package:demo/serach_screen.dart';
import 'package:demo/setting_screen.dart';
import 'package:demo/support_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeNaveScreens extends StatefulWidget {
  int index;
  HomeNaveScreens({super.key, required this.index});

  @override
  State<HomeNaveScreens> createState() => _HomeNaveScreensState();
}

class _HomeNaveScreensState extends State<HomeNaveScreens> {
  int selectIndex = 0;
  final List classes = <Widget>[
    //  CackeFizeScreen(),
    DashBord_Screen(),
    SerachScreen(),
    Support_Screen(),
    ReportScreen(),
    Setting_Screen(),
  ];

  @override
  void initState() {
    super.initState();
    DashBord_Screen();
    if (widget.index != 0) {
      selectIndex = widget.index;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: classes.elementAt(selectIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.pink,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
            // backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.support_outlined,
              // color: Colors.black,
            ),
            label: 'Support',
            // backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_sharp
                // color: Colors.black,
                ),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_outlined,
              color: Colors.black,
            ),
            label: 'Profile',
            // backgroundColor: Colors.white
          ),
        ],
        currentIndex: selectIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
