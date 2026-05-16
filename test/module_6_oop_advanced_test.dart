import 'package:module_6_oop_advanced/oop_advanced_practice.dart';
import 'package:test/test.dart';

void main() {
  test('Bank Account Initial Balance Test', () {
    var account = BankAccount("Test User", 100.0);
    expect(account.balance, 100.0);
  });
}