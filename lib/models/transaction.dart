// this is not a widget, its a dart class
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String title;
  final double ammount;
  final DateTime date;
  final TimeOfDay time;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.ammount,
    @required this.date,
    @required this.time,
  });
}
