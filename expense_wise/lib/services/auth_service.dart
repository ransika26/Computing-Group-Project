import 'package:expense_wise/Screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expense_wise/Screens/dashboard.dart';
import 'package:expense_wise/services/db.dart';

import '../widgets/auth_gate.dart';

class AuthService {
  var db = Db();

  createUser(data, context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      await db.addUser(data, context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => Dashboard())),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Sign Up Failed"),
            content: Text(e.toString()),
          );
        },
      );
    }
  }

  login(data, context) async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      String userEmail = userCredential.user!.email!;
      // You can use userEmail as needed, for example, to display it in your UI
      print('User email: $userEmail');

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => Dashboard())),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Login Error"),
            content: Text(e.toString()),
          );
        },
      );
    }
  }



  Future<void> deleteuser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
      
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => AuthGate())),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to delete account: ${e.toString()}"),
          );
        },
      );
    }
  }



  Future<void> logOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => LoginView())),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to logout: ${e.toString()}"),
          );
        },
      );
    }
  }

}
