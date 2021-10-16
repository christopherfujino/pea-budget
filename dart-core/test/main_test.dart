import 'package:pea_budget_core/pea_budget.dart';
import 'package:test/test.dart';

void main() {
  group('simulator.simulate()', () {
    test('compounding interest', () {
      final InterestAction interest = InterestAction(
        name: '2% interest',
        rate: 0.02,
        numPeriods: 4,
      );
      final FinancialState state = FinancialState(
        accounts: <Account>[
          BankAccount(
            actions: <Action>[interest],
            initialBalance: 1000,
            name: 'savings',
          ),
        ],
        currentTime: DateTime.now(),
      );
      final Simulator simulator = Simulator(
        duration: Duration(days: 365 * 20),
        simulationInterval: Duration(days: 30),
        startingState: state,
      );
      final FinancialState finishedState = simulator.simulate();
      expect(finishedState.balance, 1490.34);
    });
  });
}
