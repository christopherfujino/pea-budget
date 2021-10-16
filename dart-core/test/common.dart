import 'package:test/test.dart' show expect;

void expectWithin(
  double actual,
  double expected, {
  double acceptedDiff = 0.0099,
  String? reason,
}) {
  if (reason == null) {
    reason = 'expected $expected but received $actual';
  }
  expect(
    (actual - expected).abs() <= acceptedDiff,
    true,
    reason: reason,
  );
}
