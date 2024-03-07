import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key, required this.selectedIndex, required this.onDestinationSelected});
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        indicatorColor: Color.fromARGB(255, 1, 4, 40),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        height: 60,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            selectedIcon: Icon(Icons.home, color: Colors.white,),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore),
            selectedIcon: Icon(Icons.explore, color: Colors.white,),
            label: 'Transaction',
          ),
        ],
      );
    }
}
