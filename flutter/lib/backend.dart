import 'dart:io' as io;

import 'src/transactions.dart' show Transaction;

const String _seedPath = '../../seeds/chase-seed.csv';

Future<void> main() async {
  final String contents = await readFromFile(_seedPath);
  io.stdout.writeln(parseContents(contents).join('\n'));
}

Future<String> readFromFile(String path) async {
  final io.File file = io.File(path);
  return (await file.readAsString()).trim();
}

List<Transaction> parseContents(String input) {
  final List<String> lines = input.split('\n');
  return lines.map<Transaction>((String line) {
    return Transaction.fromCSVLine(line);
  }).toList();
}
