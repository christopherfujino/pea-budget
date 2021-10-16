import 'accounts.dart' show Account, BankAccount;
import 'actions.dart' show Action;
import 'financial_states.dart' show FinancialState;
import 'transactions.dart' show Transaction;

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
  void visitBankAccount(BankAccount that) {
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

abstract class Visitor {
  void visitFinancialState(FinancialState that);
  void visitBankAccount(BankAccount that);
  void visitTransaction(Transaction that);
}

mixin Visitable {
  void accept(Visitor visitor);
}
