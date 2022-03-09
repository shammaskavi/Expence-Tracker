import './adaptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'dart:io';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _ammountController = TextEditingController();
  DateTime _selectedDate;

/*
      Widget Lifecycle
  _NewTransactionState() {
    print('Constructor New Transaction State');
  }

  @override
  void initState() {
    super.initState();
    print("Init State");
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget(oldWidget)');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
  } 
*/

/*
    App Lifecycle
  - inactive: App is inactive, no user input is recived
  - paused: App not visible to user, running in background (in the recent apps screen)
  - resumed: App is (again) visible and responding to user input (when app is opened from the recent apps screen)
  - suspending: App is about to be suspended( when the app is about to be exited)
*/
  void _submitData() {
    if (_ammountController.text.isEmpty) {
      return;
    }

    if (_selectedDate == null) {
      setState(() {
        _selectedDate = DateTime.now();
      });
    }

    final enteredTitle = _titleController.text;
    final enteredAmmount = double.parse(_ammountController.text);

    if (enteredTitle.isEmpty || enteredAmmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 3,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // CupertinoTextField(),
              TextField(
                decoration: const InputDecoration(labelText: "Title"),
                // onChanged: (val) => textInput = val,
                onSubmitted: (_) => _submitData(),
                controller: _titleController,
              ),

              TextField(
                decoration: const InputDecoration(labelText: "Ammount"),
                // onChanged: (val) => ammountInput = val,
                controller: _ammountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),

              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? "No Date Chosen"
                            : 'Date Selected: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    AdaptiveFlatButton(
                      "Choose Date",
                      _presentDatePicker,
                    )
                  ],
                ),
              ),

              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Add Transaction",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.button.color),
                ),
                onPressed: _submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}


// why do we fall?? so that we can learn to pick ourselves up 