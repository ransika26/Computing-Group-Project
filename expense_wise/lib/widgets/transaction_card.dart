<<<<<<< Updated upstream
import 'package:expense_wise/utils/icons_list.dart';
=======
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_wise/utils/icons_list.dart';
import 'package:expense_wise/widgets/transaction_cards.dart';
import 'package:firebase_auth/firebase_auth.dart';
>>>>>>> Stashed changes
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionCard extends StatelessWidget {
  TransactionCard({super.key});

<<<<<<< Updated upstream
  var appIcons = AppIcons();
=======
>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Recent Transactions",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              )
            ],
          ),
<<<<<<< Updated upstream
          ListView.builder(
              shrinkWrap: true,
              itemCount: 4,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0,10),
                          color: Colors.grey.withOpacity(0.09),
                          blurRadius: 10.0,
                          spreadRadius: 4.0
                        )
                      ]
                    ),
                    child: ListTile(
                      minVerticalPadding: 8,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      leading: Container(
                        width: 70,
                        height: 100,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.green.withOpacity(0.2)
                          ),
                          child: Center(
                            child: FaIcon(
                              appIcons.getExpenseCategoryIcons('Grocery')
                            ),
                          ),
                        ),
                      ),
                      title: Row(
                        children: [
                          Expanded(child: Text("Car Rent Jan 2024")),
                          Text(
                            "Rs 25000",
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Balance",
                                  style:
                                      TextStyle(color: Colors.grey, fontSize: 12)),
                              Spacer(),
                              Text("Rs 75000",
                                  style:
                                      TextStyle(color: Colors.grey, fontSize: 12))
                            ],
                          ),
                          Text(
                            "28 Jan 5.30 PM",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })
=======
          RecentTransactionList()
>>>>>>> Stashed changes
        ],
      ),
    );
  }
}
<<<<<<< Updated upstream
=======

class RecentTransactionList extends StatelessWidget {
  RecentTransactionList({
    super.key,
  });

  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection("transactions")
            .orderBy('timestamp', descending: true)
            .limit(20)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No transactions found"),
            );
          }

          var data = snapshot.data!.docs;

          return ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var cardData = data[index];
                return TransactionCards(
                  data: cardData,
                );
              });
        });
  }
}
>>>>>>> Stashed changes
