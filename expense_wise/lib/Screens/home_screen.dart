import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_wise/services/shared_preferences.dart';
import 'package:expense_wise/widgets/add_transaction_form.dart';
import 'package:expense_wise/widgets/transaction_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/hero_card.dart';
import 'login_screen.dart';

import 'package:expense_wise/Screens/setgoal.dart';
//ignore_for_file: prefer_const_constructors
//ignore_for_file: prefer_const_literals_to_create_immutables

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key?key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  var isLogoutLoading = false;


  //Dynimically Name Fetching



  logOut() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: ((context) => LoginView())),
    );
    setState(() {
      isLogoutLoading = false;
    });
  }

  final userId = FirebaseAuth.instance.currentUser!.uid;

  _dialogBuilder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: AddTransactionForm(),
        );
      },
    );
  }

 //navigate to set GOAL

  _navigateToGoalSetting(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Your Goals'), // Customize the title as needed
          content: GoalPage(), // Use GoalPage widget here or any custom widget for goal setting
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Close'), // Customize the button text as needed
            ),
          ],
        );
      },
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 211, 64, 3),
        onPressed: (() {
          _dialogBuilder(context);
        }),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 34, 34, 40),
        title: Text(
          "Hi,",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              logOut();
            },
            icon: isLogoutLoading
                ? CircularProgressIndicator()
                : Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              _navigateToGoalSetting(context);
            },
            icon: Icon(
              Icons.alarm_rounded,
              color: Colors.red.shade200,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroCard(
              userId: userId,
            ),
            TransactionCard(),
          ],
        ),
      ),
    );
  }
}
