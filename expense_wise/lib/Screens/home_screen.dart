import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_wise/services/shared_preferences.dart';
import 'package:expense_wise/widgets/add_transaction_form.dart';
import 'package:expense_wise/widgets/transaction_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/hero_card.dart';
import 'login_screen.dart';

import 'package:expense_wise/Screens/setgoal.dart';


class HomeScreen extends StatefulWidget {

  const HomeScreen({Key?key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = 'User';
  var isLogoutLoading = false;


  //Dynimically Name Fetching

  Future<void> getthesharedpref() async {
    try {
      // Get the profile image URL from shared preferences
      String? imageUrl = await SharedPreferenceHelper.getUserProfile();


      // Get the authenticated user
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Get the user document from Firestore using the user's UID
        DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        // get name from the user document
        if (userDoc.exists) {
          name = userDoc['username'];

          setState(() {});
        } else {
          print('User document does not exist');

        }
      }
    } catch (e) {

      print("Error fetching user data: $e");

    }
  }


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
          title: Text('Add Your Goals'),
          content: GoalPage(),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getthesharedpref();
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
          "Hi, $name",
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
