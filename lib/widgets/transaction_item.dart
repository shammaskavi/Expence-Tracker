import 'dart:math';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final Function rmvFunc;

  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.rmvFunc,
  }) : super(key: key);

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ),
        elevation: 3,
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).accentColor,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(
                child: Text(
                  '₹ ${widget.transaction.ammount}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          title: Text(
            widget.transaction.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Column(
            children: [
              Text(DateFormat.yMMMMd().format(widget.transaction.date)),
            ],
          ),
          trailing: MediaQuery.of(context).size.width > 360
              ? FlatButton.icon(
                  icon: const Icon(Icons.delete_outline_rounded),
                  textColor: Theme.of(context).errorColor,
                  label: const Text("Delete"),
                  onPressed: () => widget.rmvFunc(widget.transaction.id),
                )
              : IconButton(
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: Theme.of(context).errorColor,
                  ),
                  onPressed: () => widget.rmvFunc(widget.transaction.id),
                ),
        ),
      ),
    );
  }
}
// define fermi paradox