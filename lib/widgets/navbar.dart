
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBar extends StatelessWidget {
  final Widget child;

  const NavBar({super.key, required this.child});

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    switch (location) {
      case '/':
        return 0;
      case '/expenses':
        return 1;
      case '/analytics':
        return 2;
      case '/profile':
        return 3;
      default:
        return 0;
    }
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/expenses');
        break;
      case 2:
        context.go('/analytics');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getCurrentIndex(context),
        onTap: (value) => _onTap(context, value),
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