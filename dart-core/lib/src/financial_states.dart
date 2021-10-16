import 'accounts.dart' show Account;
import 'transactions.dart' show TransactionHistory;
import 'utils.dart';
import 'visitors.dart' show Visitable, Visitor;

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

  // AKA net worth
  double get balance {
    // probably not worth caching as each account's balance will be cached
    // and we'd have to do O(n) check anyway to validate cache freshness.
    return roundToPenny(accounts.fold<double>(
      0,
      (double total, Account account) => total + account.balance,
    ));
  }

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
