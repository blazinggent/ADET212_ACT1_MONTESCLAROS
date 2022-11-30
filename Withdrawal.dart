import 'BankDatabase.dart';
import 'CashDispenser.dart';
import 'Screen.dart';
import 'Transaction.dart';
import 'Keypad.dart';

class Withdrawal extends Transaction {
  int? amount;
  Keypad? keypad;
  CashDispenser? cashDispenser;

  static final int CANCELLED = 5;

  Withdrawal(int accountNumber, Screen screen, BankDatabase bankDatabase,
      this.keypad, this.cashDispenser)
      : super(accountNumber, screen, bankDatabase);
      
  @override
  void execute() {
    bool cashDispensed = false;
    double availableBalance;

    BankDatabase bankDatabase = getBankDatabase();
    Screen screen = getScreen();

    do {
      amount = displayMenuOfAmounts();

      if (amount != CANCELLED) {
        availableBalance = bankDatabase.getAvailableBalance(getAccountNumber());
        if (amount! <= availableBalance) {
          if (cashDispenser!.isSufficientCashAvailable(amount!)) {
            bankDatabase.debit(getAccountNumber(), amount! * 1.0);

            cashDispenser!.dispenseCash(amount!);
            cashDispensed = true;

            screen.displayMessage(
                "\nYour cash has been dispensed. Please collect cash through the ATM slot.");
          } else {
            screen.displayMessage(
                "\nInsufficient cash available in the ATM. \n Please select a smaller amount.");
          }
        } else {
          screen.displayMessage(
              "\nInsufficient funds in account. \n Please select a smaller amount.");
        }
      }
      cashDispensed = true;
    } while (!cashDispensed);
  }

  int displayMenuOfAmounts() {
    int choice = 0;
    Screen screen = getScreen();
    List<int> amounts = [0, 100, 200, 500, 1000];

    while (choice == 0) {
      screen.displayMessage("\nWithdrawal Menu:");
      screen.displayMessage("1 - \₱100");
      screen.displayMessage("2 - \₱200");
      screen.displayMessage("3 - \₱500");
      screen.displayMessage("4 - \₱1000");
      screen.displayMessage("5 - Cancel transaction");
      screen.displayMessage("\nSelect a withdrawal amount: ");

      int input = keypad!.getInput();

      switch (input) {
        case 1:
        case 2:
        case 3:
        case 4:
          choice = amounts[input];
          break;
        case 5:
          choice = CANCELLED;
          break;
        default:
          screen.displayMessage("\nInvalid selection. Try again.");
      }
    }

    return choice;
  }
}
