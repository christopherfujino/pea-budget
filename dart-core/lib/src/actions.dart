import 'accounts.dart' show Account;
import 'transactions.dart' show Transaction;
import 'visitors.dart' show Visitable;

abstract class Action<P extends Visitable> {
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

  Duration _sinceLastExecution = Duration.zero;

  void run({
    required Duration lapsedTime,
    required DateTime currentTime,
    required Account parent,
  }) {
    _sinceLastExecution += lapsedTime;
    if (_sinceLastExecution >= interval) {
      // If it is time to schedule this action
      do {
        _sinceLastExecution -= interval;
        //print('adding an interest transaction to ${parent.name}');
        //print('with ${parent.history.transactions.length} transactions');
        parent.history.add(
          Transaction(
            date: currentTime,
            description: 'Apply ${ratePerPeriod * 100}% interest for $name',
            amount: parent.balance * ratePerPeriod,
          ),
        );
      } while (_sinceLastExecution >= interval);
    }
  }
}
