import 'BankDatabase.dart';
import 'Screen.dart';
import 'Transaction.dart';

class BalanceInquiry extends Transaction {
  BalanceInquiry(int accountNumber, Screen screen, BankDatabase bankDatabase)
      : super(accountNumber, screen, bankDatabase);

  @override
  void execute() {
    BankDatabase bankDatabase = getBankDatabase();
    Screen screen = getScreen();

    double availableBalance =
        bankDatabase.getAvailableBalance(getAccountNumber());
    double accountBalance = bankDatabase.getAccountBalance(getAccountNumber());

    screen.displayMessage("\nBalance Information:");
    screen.displayMessage("\nAvailable Balance: ");
    screen.displayDollarAmount(availableBalance);
    screen.displayMessage("\nAccount Balance: ");
    screen.displayDollarAmount(accountBalance);
    screen.displayMessage("");
  }
}
