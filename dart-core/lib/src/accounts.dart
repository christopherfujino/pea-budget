import 'actions.dart';
import 'transactions.dart';
import 'visitors.dart';

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
