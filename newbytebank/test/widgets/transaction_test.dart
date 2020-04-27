import 'package:flutter_test/flutter_test.dart';
import 'package:newbytebank/models/Transaction.dart';

void main() {
  test('Should return the value when create a transaction', () {
    final transaction = Transaction(null, 200, null);
    expect(transaction.value, 200);
  });
  test('Should show error when cerate transaction if value less then zero', () {
    expect(() => Transaction(null, 0, null), throwsAssertionError);
  });
}