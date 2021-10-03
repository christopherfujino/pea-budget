import 'dart:io' as io;

import 'package:flutter/material.dart';

class TransactionsWidget extends StatelessWidget {
  const TransactionsWidget(this.transactions, {Key? key}) : super(key: key);

  final List<Transaction> transactions;

  static final List<Widget Function(Transaction)> _callbacks =
      <Widget Function(Transaction)>[
    (Transaction transaction) => Text(transaction.transactionDate.toString()),
    (Transaction transaction) => Text(transaction.description),
    (Transaction transaction) => Text('\$${transaction.amount}'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: transactions.map<Widget>((Transaction transaction) {
        return Row(
          children: _callbacks.map<Widget>((Function cb) {
            return cb(transaction);
          }).toList(),
        );
      }).toList(),
    );
  }
}

class Transaction {
  Transaction._({
    required this.transactionDate,
    required this.description,
    required this.originalDescription,
    required this.amount,
    required this.type,
    required this.category,
    required this.accountName,
  });

  /// Parse a Transaction from a single line from a CSV.
  ///
  /// Date,Description,Original Description,Amount,
  /// Transaction Type,Category,Account Name,Labels,Notes
  factory Transaction.fromCSVLine(String line) {
    final List<String> fields = line
        .split(',')
        .map<String>((String input) => input.replaceAll(r'"', r''))
        .toList();
    final List<String> dateParts = fields[0].split(r'/');

    try {
      final int month = int.parse(dateParts[0]);
      final int day = int.parse(dateParts[1]);
      final int year = int.parse(dateParts[2]);
      return Transaction._(
        transactionDate: DateTime(
          year, // year
          month, // month
          day, // day
        ),
        description: fields[1].replaceAll(r'"', r''),
        originalDescription: fields[2].replaceAll(r'"', r''),
        amount: double.parse(fields[3].replaceAll(r'"', r'')),
        type: fields[4].replaceAll(r'"', r''),
        category: fields[5].replaceAll(r'"', r''),
        accountName: fields[6].replaceAll(r'"', r''),
      );
    } on FormatException catch (_) {
      io.stderr.writeln('FormatException on line "$line"');
      rethrow;
    }
  }

  final DateTime transactionDate;
  final String description;
  final String originalDescription;
  final double amount;

  /// Debit or credit.
  final String type; // TODO make this an enum
  final String category;
  final String accountName;

  @override
  String toString() {
    return '$transactionDate,$description,$originalDescription,'
        '\$$amount,$type,$category,$accountName';
  }
}
