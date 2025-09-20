

import 'package:ai_finance_manager/pages/analytics_page.dart';
import 'package:ai_finance_manager/pages/expenses_page.dart';
import 'package:ai_finance_manager/pages/home_page.dart';
import 'package:ai_finance_manager/pages/profile_page.dart';
import 'package:flutter/material.dart';

import '../constants/themes.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  int currentIndex = 0;

  switchPages(int value) {
    setState(() {
      currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentIndex == 0 
        ? HomePage()
        : currentIndex == 1
          ? ExpensesPage()
          : currentIndex == 2
            ? AnalyticsPage()
            : ProfilePage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) => switchPages(value),
        showUnselectedLabels: false,
        selectedItemColor: primaryClr,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.space_dashboard_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money_rounded),
            label: "Expenses",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: "Analytics",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_4_outlined),
            label: "Profile",
          ),
        ]
      ),
    );
  }
}