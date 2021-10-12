import 'package:pea_budget_core/pea_budget.dart';

void main() {
  final InterestAction interest = InterestAction(
    name: '2% interest',
    amount: 0.02,
    interval: Duration(days: 365),
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
  final Printer printer = Printer();

  final FinancialState finishedState = simulator.simulate();
  printer.visitFinancialState(finishedState);
  print(printer.toString());
}
