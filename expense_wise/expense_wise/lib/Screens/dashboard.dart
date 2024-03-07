import 'package:expense_wise/Screens/home_screen.dart';
import 'package:expense_wise/Screens/transaction_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/navbar.dart';
import 'login_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var isLogoutLoading = false;
  int currentIndex = 0;
  var pageViewList = [
    HomeScreen(),
    TransactionScreen()
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (int value) {
          setState(() {
            currentIndex = value;
          });
        },),

      body: pageViewList[currentIndex],
    );
  }
}
