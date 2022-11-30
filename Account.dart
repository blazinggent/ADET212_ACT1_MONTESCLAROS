import 'dart:math';

class Account {
  int accountNumber;
  int pin;
  double availableBalance;
  double accountBalance;

  Account(
      this.accountNumber, this.pin, this.availableBalance, this.accountBalance);

  bool validatePIN(int pin) => (pin == this.pin) ? true : false;
  double getAvailableBalance() => availableBalance;
  double getAccountBalance() => accountBalance;
  int getAccountNumber() => accountNumber;
  void credit(double amount) => accountBalance += amount;
  void debit(double amount) {
    availableBalance -= amount;
    accountBalance -= amount;
  }
}
