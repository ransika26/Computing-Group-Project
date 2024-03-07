import 'package:expense_wise/widgets/category_dropdown.dart';
import 'package:flutter/material.dart';

import '../utils/appvalidator.dart';

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({super.key});

  @override
  State<AddTransactionForm> createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  var type = "credit";
  var category = "Others";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var isLoader = false;
  var appValidator = AppValidator();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });
      // var data = {
      //   "email": _emailController.text,
      //   "password": _passwordController.text,
      // };
      //
      // await authService.login(data, context);

      setState(() {
        isLoader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: appValidator.isEmptyCheck,
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: appValidator.isEmptyCheck,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Amount"),
            ),
            CategoryDropDown(
              cattype: category,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    category = value;
                  });
                }
              },
            ),
            DropdownButtonFormField(
                value: 'credit',
                items: [
                  DropdownMenuItem(
                    child: Text('Credit'),
                    value: 'credit',
                  ),
                  DropdownMenuItem(
                    child: Text('Debit'),
                    value: 'debit',
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      type = value;
                    });
                  }
                }),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  if(isLoader == false){
                    _submitForm();
                  }
                },
                child:
                isLoader ? Center(child: CircularProgressIndicator()):
                Text("Add Transaction"))
          ],
        ),
      ),
    );
  }
}
