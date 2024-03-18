import 'dart:ui';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; 

class PieChartScreen extends StatelessWidget {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    // Generate random colors for each category
    final Map<String, Color> categoryColors = {};

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Distribution', style: TextStyle(color: Colors.white)), // Set title text color
        backgroundColor: Colors.black, 
        elevation: 0, 
        centerTitle: true, 
        leading: IconButton(
          icon: Icon(
            Icons.menu, 
            color: Colors.white, 
          ),
          onPressed: () {
          
          },
        ),
        
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey[300]!, 
                  Colors.grey[800]!, 
                ],
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .collection("transactions")
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Something went wrong', style: TextStyle(color: Colors.red)), // Error text color
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text("No transactions found", style: TextStyle(fontSize: 18))); 
              }

              

  // Function to generate random colors 
  Color getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}
