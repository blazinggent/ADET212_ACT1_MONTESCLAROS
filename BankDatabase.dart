import 'Account.dart';
import 'dart:io';

class BankDatabase {
  List<Account> accounts = [];

  BankDatabase() {
    accounts.add(new Account(12345, 54321, 1000.0, 1200.0));
    accounts.add(new Account(98765, 56789, 200.0, 200.0));
  }

  Account? getAccount(int accountNumber) {
    for (Account currentAccount in accounts) {
      if (currentAccount.getAccountNumber() == accountNumber) {
        return currentAccount;
      }
    }

    return null;
  }

  bool authenticateUser(int accountNumber, int pin) {
    Account? account = getAccount(accountNumber);
    return (account != null) ? account.validatePIN(pin) : false;
  }

  double getAvailableBalance(int accountNumber) =>
      getAccount(accountNumber)!.getAvailableBalance();
  double getAccountBalance(int accountNumber) =>
      getAccount(accountNumber)!.getAccountBalance();
  void credit(int accountNumber, double amount) =>
      getAccount(accountNumber)!.credit(amount);
  void debit(int accountNumber, double amount) =>
      getAccount(accountNumber)!.debit(amount);
}
