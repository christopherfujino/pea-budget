import 'dart:collection' show SplayTreeSet;

import 'visitors.dart';

class Transaction with Visitable {
  const Transaction({
    required this.amount,
    required this.date,
    required this.description,
  });

  final String description;
  final DateTime date;
  final double amount; // TODO: make this a class

  // TODO link to parent?

  void accept(Visitor visitor) {
    visitor.visitTransaction(this);
  }
}

class TransactionHistory {
  TransactionHistory._(SplayTreeSet<Transaction> transactions)
      : _transactions = transactions;

  factory TransactionHistory() {
    return TransactionHistory._(
      SplayTreeSet<Transaction>(_comparator),
    );
  }

  final SplayTreeSet<Transaction> _transactions;

  List<Transaction> get transactions {
    // TODO cache this
    return _transactions.toList();
  }

  void addAll(Iterable<Transaction> trxs) => _transactions.addAll(trxs);

  void add(Transaction trx) => _transactions.add(trx);

  TransactionHistory clone() {
    return TransactionHistory._(
      SplayTreeSet<Transaction>.from(
        _transactions,
        _comparator,
      ),
    );
  }

  static int _comparator(Transaction first, Transaction second) {
    if (first.date.isBefore(second.date)) {
      return -1;
    } else if (first.date.isAfter(second.date)) {
      return 1;
    } else {
      //return 0;
      return -1; // Hmph
    }
  }
}
