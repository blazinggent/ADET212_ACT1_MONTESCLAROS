import 'BankDatabase.dart';
import 'Screen.dart';
import 'Transaction.dart';
import 'Keypad.dart';

class Deposit extends Transaction {
  double? amount;
  Keypad? keypad;

  static final int CANCELLED = 0;

  Deposit(
      int accountNumber, Screen screen, BankDatabase bankDatabase, this.keypad)
      : super(accountNumber, screen, bankDatabase);

  @override
  void execute() {
    BankDatabase bankDatabase = getBankDatabase();
    Screen screen = getScreen();

    amount = promptForDepositAmount();

    if (amount != CANCELLED) {
      screen.displayMessage("\nPlease insert a stack of bills containing ");
      screen.displayDollarAmount(amount!);

      screen.displayMessage("\nYour deposit has been received.");

      bankDatabase.credit(getAccountNumber(), amount!);
    } else {
      screen.displayMessage("\nCancelling transaction...");
    }
  }

  double promptForDepositAmount() {
    Screen screen = getScreen();

    screen.displayMessage("\nPlease enter a deposit amount (or 0 to cancel): ");
    int input = keypad!.getInput();

    if (input == CANCELLED) {
      return CANCELLED * 1.0;
    } else {
      return input * 1.0;
    }
  }
}
