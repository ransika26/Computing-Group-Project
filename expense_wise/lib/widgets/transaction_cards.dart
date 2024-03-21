import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_wise/widgets/add_transaction_form.dart';
import '../utils/icons_list.dart';

class TransactionCards extends StatelessWidget {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  TransactionCards({
    Key? key,
    required this.data,
  });

  final dynamic data;

  var appIcons = AppIcons();

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(data['timestamp']);
    String formattedDate = DateFormat('d MMM hh:mma').format(date);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              color: Colors.grey.withOpacity(0.09),
              blurRadius: 10.0,
              spreadRadius: 4.0,
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
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
                      color: data['type'] == 'credit'
                          ? Colors.green.withOpacity(0.2)
                          : Colors.red.withOpacity(0.2),
                    ),
                    child: Center(
                      child: FaIcon(
                        appIcons.getExpenseCategoryIcons('${data['category']}'),
                        color: data['type'] == 'credit'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ),
                ),
                title: Row(
                  children: [
                    Expanded(child: Text("${data['title']}")),
                    Text(
                      "${data['type'] == 'credit' ? '+':'-'} Rs${data['amount']}",
                      style: TextStyle(
                        color: data['type'] == 'credit'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Balance",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Spacer(),
                        Text(
                          "Rs ${data['remainingAmount']}",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    Text(
                      formattedDate,
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  // Print the document ID before deletion
                  print('Deleting transaction with ID: ${data['id']}');

                  // Delete the transaction document from Firestore using its ID
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .collection('transactions')
                      .doc(data['id'])
                      .delete();
                  print('Transaction deleted successfully.');

                  // Call the deleteTransaction function passing the necessary parameters
                  await deleteTransaction(data['id'], data['amount'], data['type']);
                } catch (e) {
                  // Handle any errors that occur during deletion
                  print('Error deleting transaction: $e');
                }
              },
            )


          ],
        ),
      ),
    );
  }
}
