import 'Screen.dart';
import 'BankDatabase.dart';

abstract class Transaction {
  int accountNumber;
  Screen screen;
  BankDatabase bankDatabase;

  Transaction(this.accountNumber, this.screen, this.bankDatabase);

  int getAccountNumber() => accountNumber;
  Screen getScreen() => screen;
  BankDatabase getBankDatabase() => bankDatabase;

  void execute();
}
