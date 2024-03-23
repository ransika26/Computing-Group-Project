import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/icons_list.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({Key? key}) : super(key: key);

  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  final AppIcons appIcons = AppIcons();
  Map<String, double> goals = {};

  void saveGoals() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final goalsCollection = FirebaseFirestore.instance.collection('users').doc(userId).collection('goals');

    goals.forEach((category, amount) async {
      await goalsCollection.add({
        'userId': userId,
        'category': category,
        'amount': amount,
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Goals saved successfully')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Goals'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: appIcons.homeExpensesCategories.map((categoryData) {
                  String category = categoryData['name'];
                  IconData iconData = categoryData['icon'];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Icon(iconData),
                        Text(
                          category,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: appIcons.homeExpensesCategories.length,
                itemBuilder: (context, index) {
                  String category = appIcons.homeExpensesCategories[index]['name'];
                  IconData iconData = appIcons.homeExpensesCategories[index]['icon'];
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      leading: Icon(iconData),
                      title: SizedBox(
                        width: 120,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Amount'),
                          onChanged: (value) {
                            setState(() {
                              goals[category] = double.tryParse(value) ?? 0;
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: saveGoals,
        child: Icon(Icons.save),
      ),
    );
  }
}
