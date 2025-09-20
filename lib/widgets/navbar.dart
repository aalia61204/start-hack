
import 'package:ai_finance_manager/pages/analytics_page.dart';
import 'package:ai_finance_manager/pages/expenses_page.dart';
import 'package:ai_finance_manager/pages/home_page.dart';
import 'package:ai_finance_manager/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex = 0;

  void switchPages(int value) {
    setState(() {
      currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentIndex == 0 
        ? const HomePage()
        : currentIndex == 1
          ? const ExpensesPage()
          : currentIndex == 2
            ? const AnalyticsPage()
            : const ProfileScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) => switchPages(value),
        showUnselectedLabels: false,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.space_dashboard_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_outlined),
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
        ],
      ),
    );
  }
}