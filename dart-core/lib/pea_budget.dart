import 'dart:collection';

class Simulator implements Visitor {
  Simulator({
    required this.startingState,
    required this.duration,
    required this.simulationInterval,
  });

  final FinancialState startingState;
  final Duration duration;
  final Duration simulationInterval;
  late final FinancialState simulationState = startingState.clone();

  @override
  void visitFinancialState(FinancialState that) {
    for (final Account account in that.accounts) {
      account.accept(this);
    }
  }

  @override
  void visitBankAccount(Account that) {
    for (final Action action in that.actions) {
      action.run(
        lapsedTime: simulationInterval,
        currentTime: simulationState.currentTime,
        parent: that,
      );
    }
  }

  @override
  void visitTransaction(Transaction that) {
    throw Exception('Unimplemented!');
  }

  FinancialState simulate() {
    Duration elapsedTime = Duration.zero;

    while (elapsedTime < duration) {
      elapsedTime += simulationInterval;
      // Must update this before simulating
      simulationState.currentTime.add(simulationInterval);

      visitFinancialState(simulationState);
    }
    // TODO things
    return simulationState;
  }
}

class Printer implements Visitor {
  final StringBuffer _buffer = StringBuffer();

  int _indentLevel = 0;
  String get _indent => '  ' * _indentLevel;

  void visitFinancialState(FinancialState that) {
    _writeln('Hi');

    _withIndent(() {
      for (final Account account in that.accounts) {
        account.accept(this);
      }
    });
  }

  void visitBankAccount(Account that) {
    _writeln('Bank Account: ${that.name}');
    _writeln('balance: \$${that.balance}');
    if (that.actions.isNotEmpty) {
      _writeln('Actions:');
      _withIndent(() {
        for (final Action action in that.actions) {
          _writeln(action.name);
        }
      });
    }
    if (that.history.transactions.isNotEmpty) {
      _writeln('Transactions:');
      _withIndent(() {
        for (final Transaction trx in that.history.transactions) {
          trx.accept(this);
        }
      });
    }
  }

  void visitTransaction(Transaction that) {
    _writeln('${that.description}\t\$${that.amount}');
  }

  void _writeln(String string) {
    _buffer.writeln('${_indent}$string');
  }

  void _withIndent(void Function() callback) {
    _indentLevel += 1;
    callback();
    _indentLevel -= 1;
  }

  @override
  String toString() {
    return _buffer.toString();
  }
}

class FinancialState with Visitable {
  FinancialState({
    required List<Account> this.accounts,
    required DateTime this.currentTime,
  });

  factory FinancialState.empty([DateTime? time]) {
    return FinancialState(
      accounts: <Account>[],
      currentTime: time ?? DateTime.now(),
    );
  }

  final List<Account> accounts;
  final DateTime currentTime;

  TransactionHistory get transactionHistory {
    // TODO cache
    final TransactionHistory newHistory = TransactionHistory();

    for (final Account account in accounts) {
      newHistory.addAll(account.history.transactions);
    }

    return newHistory;
  }

  FinancialState clone() {
    return FinancialState(
      accounts: accounts.map<Account>((Account acc) => acc.clone()).toList(),
      currentTime: currentTime,
    );
  }

  void accept(Visitor visitor) {
    visitor.visitFinancialState(this);
  }
}

abstract class Action<P> {
  Action({
    required this.name,
  });

  final String name;

  void run({
    required Duration lapsedTime,
    required DateTime currentTime,
    required P parent,
  });
}

class InterestAction extends Action<Account> {
  InterestAction({
    required this.rate,
    required this.numPeriods,
    String? name,
  })  : assert(rate >= 0 && rate <= 1),
        super(
          name: name ?? '${rate * 100}% interest',
        );

  final double rate;
  final int numPeriods;
  double get ratePerPeriod => rate / numPeriods;
  Duration get interval => const Duration(days: 365) ~/ numPeriods;

  Duration sinceLastExecution = Duration.zero;

  void run({
    required Duration lapsedTime,
    required DateTime currentTime,
    required Account parent,
  }) {
    sinceLastExecution += lapsedTime;
    if (sinceLastExecution >= interval) {
      // If it is time to schedule this action
      do {
        sinceLastExecution -= interval;
        //print('adding an interest transaction to ${parent.name}');
        //print('with ${parent.history.transactions.length} transactions');
        parent.history.add(
          Transaction(
            date: currentTime,
            description: 'Apply ${ratePerPeriod * 100}% interest for $name',
            amount: parent.balance * ratePerPeriod,
          ),
        );
      } while (sinceLastExecution >= interval);
    }
  }
}

abstract class Account with Visitable {
  Account({
    required String this.name,
    TransactionHistory? history,
    List<Action>? actions,
  })  : this.history = history ?? TransactionHistory(),
        this.actions = actions ?? <Action>[];

  final TransactionHistory history;
  final String name;
  final List<Action> actions;
  double get balance;

  Account clone();
}

class BankAccount extends Account {
  BankAccount({
    required String name,
    TransactionHistory? history,
    List<Action>? actions,
    required double initialBalance,
  }) : _initialBalance = initialBalance, super(
    actions: actions,
    history: history,
    name: name,
  );

  final double _initialBalance;

  double get balance {
    // TODO cache?
    return history.transactions.fold<double>(
      _initialBalance,
      (double acc, Transaction trx) => acc + trx.amount,
    );
  }

  void accept(Visitor visitor) {
    visitor.visitBankAccount(this);
  }

  Account clone() {
    return BankAccount(
      actions: actions,
      name: name,
      initialBalance: _initialBalance,
      history: history.clone(),
    );
  }
}

//enum TimeIntervalType {
//  day,
//  week,
//  month,
//  year,
//}
//
//class TimeInterval {
//  const TimeInterval({
//    required this.type,
//    required this.value,
//  }) : assert(value >= 0);
//
//  final TimeIntervalType type;
//  final double value;
//
//  factory TimeInterval.monthly([double value = 1]) {
//    return TimeInterval(
//      type: TimeIntervalType.month,
//      value: value,
//    );
//  }
//
//  factory TimeInterval.annually([double value = 1]) {
//    return TimeInterval(
//      type: TimeIntervalType.year,
//      value: value,
//    );
//  }
//
//  DateTime nextTime(DateTime now) {
//  }
//}

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

class Transaction with Visitable {
  const Transaction({
    required this.amount,
    required this.date,
    required this.description,
  });

  final String description;
  final DateTime date;
  final double amount; // Make this a class

  void accept(Visitor visitor) {
    visitor.visitTransaction(this);
  }
}

abstract class Visitor {
  void visitFinancialState(FinancialState that);
  void visitBankAccount(BankAccount that);
  void visitTransaction(Transaction that);
}

mixin Visitable {
  void accept(Visitor visitor);
}
