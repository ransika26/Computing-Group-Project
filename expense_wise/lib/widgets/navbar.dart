import 'package:flutter/material.dart';
import '../Screens/piechart.dart';


class NavBar extends StatelessWidget {
  const NavBar({Key? key, required this.selectedIndex, required this.onDestinationSelected});
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      indicatorColor: Color.fromARGB(255, 229, 0, 0),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      height: 60,
      destinations: <Widget>[
        NavigationDestination(
          icon: Icon(Icons.home),
          selectedIcon: Icon(Icons.home, color: Colors.white),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.explore),
          selectedIcon: Icon(Icons.explore, color: Colors.white),
          label: 'Transaction',
        ),
        // New navigation destination for expenses with pie chart
        GestureDetector(
          onTap: () {
            navigateToPieChart(context);
          },
          child: NavigationDestination(
            icon: Icon(Icons.pie_chart),
            selectedIcon: Icon(Icons.pie_chart, color: Colors.white),
            label: 'Expenses',
          ),
        ),
      ],
    );
  }

  void navigateToPieChart(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PieChartScreen()));
  }


}
