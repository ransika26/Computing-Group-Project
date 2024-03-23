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
        title: Text('Expense Distribution', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 34, 34, 40),
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
                  Colors.green!,
                  Colors.red!,
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

              // Extracting category, amount, and type information from each transaction
              final List<Map<String, dynamic>> transactionData = snapshot.data!.docs
                  .map((doc) => {
                'category': doc['category'],
                'amount': (doc['amount'] as num).toDouble(),
                'type': doc['type'],
              })
                  .toList();

              // Processing the data for credit transactions
              final Map<String, double> creditCategoryTotal = {};
              // Processing the data for debit transactions
              final Map<String, double> debitCategoryTotal = {};

              for (var data in transactionData) {
                final category = data['category'] as String;
                final amount = data['amount'] as double;
                final type = data['type'] as String;

                // transaction type and filter accordingly
                if (type == "credit") {
                  creditCategoryTotal[category] = (creditCategoryTotal[category] ?? 0) + amount;
                } else if (type == "debit") {
                  debitCategoryTotal[category] = (debitCategoryTotal[category] ?? 0) + amount;
                }
              }

              // Prepare pie chart data for credit transactions
              final List<PieChartSectionData> creditPieChartData = creditCategoryTotal.entries.map((entry) {
                categoryColors.putIfAbsent(entry.key, () => getRandomColor());
                return PieChartSectionData(
                  value: entry.value,
                  title: '${entry.key}\n${((entry.value / creditCategoryTotal.values.reduce((a, b) => a + b)) * 100).toStringAsFixed(2)}%',
                  radius: 42,
                  titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                  color: categoryColors[entry.key]!,
                );
              }).toList();

              // Prepare pie chart data for debit transactions
              final List<PieChartSectionData> debitPieChartData = debitCategoryTotal.entries.map((entry) {
                categoryColors.putIfAbsent(entry.key, () => getRandomColor());
                return PieChartSectionData(
                  value: entry.value,
                  title: '${entry.key}\n${((entry.value / debitCategoryTotal.values.reduce((a, b) => a + b)) * 100).toStringAsFixed(2)}%',
                  radius: 42,
                  titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                  color: categoryColors[entry.key]!,
                );
              }).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Credit Transactions',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Stack(
                        children: [
                          PieChart(
                            PieChartData(
                              sections: creditPieChartData,
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 0,
                              centerSpaceRadius: 130,
                              centerSpaceColor: Colors.white,
                            ),
                          ),
                          Positioned.fill(
                            child: Center(child: Image.asset('images/image(1).png')),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Debit Transactions',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Stack(
                        children: [
                          PieChart(
                            PieChartData(
                              sections: debitPieChartData,
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 0,
                              centerSpaceRadius: 130,
                              centerSpaceColor: Colors.white,
                            ),
                          ),
                          Positioned.fill(
                            child: Center(child: Image.asset('images/image(7).png')),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Function to generate random colors 
  Color getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(128), 
      random.nextInt(108), 
      random.nextInt(100) , 
    );
  }
}
