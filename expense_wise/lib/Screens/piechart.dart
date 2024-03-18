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
    
    final Map<String, Color> categoryColors = {};

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Distribution', style: TextStyle(color: Colors.white)), 
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
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white), 
            onPressed: () {
              
            },
          ),
        ],
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
                  child: Text('Something went wrong', style: TextStyle(color: Colors.red)),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text("No transactions found", style: TextStyle(fontSize: 18))); 
              }

              // category and amount information from each transaction
              final List<Map<String, dynamic>> transactionData = snapshot.data!.docs
                  .map((doc) => {
                'category': doc['category'],
                'amount': (doc['amount'] as num).toDouble(),
              })
                  .toList();

             
              final Map<String, double> categoryTotal = {};
              for (var data in transactionData) {
                final category = data['category'] as String;
                final amount = data['amount'] as double;
                categoryTotal[category] = (categoryTotal[category] ?? 0) + amount;
              }

              //  data for the pie chart
              final List<PieChartSectionData> pieChartData = categoryTotal.entries
                  .map((entry) {
                // Assign a random color to the category 
                categoryColors.putIfAbsent(entry.key, () => getRandomColor());
                return PieChartSectionData(
                  value: entry.value,
                  title: '${entry.key}\n${((entry.value / categoryTotal.values.reduce((a, b) => a + b)) * 100).toStringAsFixed(2)}%', // Category name and percentage
                  radius: 50, 
                  titleStyle: TextStyle(
                    fontSize: 10, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.white, 
                  ),
                  color: categoryColors[entry.key], 
                );
              }).toList();

            
              // category description using the same colors
              final List<Widget> categoryDescriptions = [];
              List<Widget> currentRow = [];

              for (var entry in categoryTotal.entries) {
                currentRow.add(
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        color: categoryColors[entry.key], 
                        alignment: Alignment.center,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '${entry.key}: \$${entry.value.toStringAsFixed(2)}', // Category name and amount
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
                if (currentRow.length == 3 || entry == categoryTotal.entries.last) {
                  categoryDescriptions.add(
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: currentRow,
                      ),
                    ),
                  );
                  currentRow = [];
                }
              }

             
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Stack(
                        children: [
                          PieChart(
                            PieChartData(
                              sections: pieChartData,
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 0,
                              centerSpaceRadius: 130,
                              centerSpaceColor: Colors.white,
                            ),
                          ),
                          Center(
                            child: Image.asset('images/image.png'), 
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: categoryDescriptions,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Function generate random colors 
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
