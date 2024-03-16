import 'package:expense_wise/widgets/category_list.dart';
import 'package:expense_wise/widgets/time_line_month.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Summary"),
      ),
      body: Column(
        children: [
          TimeLineMonth(
            onChanged: (String? value) {},
          ),
          CategoryList(
            onChanged: (String? value) {},
          )
        ],
      ),
    );
  }
}
