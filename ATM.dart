import 'dart:io';

import 'Screen.dart';
import 'Keypad.dart';
import 'CashDispenser.dart';
import 'BankDatabase.dart';
import 'Transaction.dart';
import 'BalanceInquiry.dart';
import 'Withdrawal.dart';
import 'Deposit.dart';

class ATM {
  bool? userAuthenticated;
  int? currentAccountNumber;
  Screen? screen;
  Keypad? keypad;
  CashDispenser? cashDispenser;
  BankDatabase? bankDatabase;

  ATM() {
    userAuthenticated = false;
    currentAccountNumber = 0;
    screen = new Screen();
    keypad = new Keypad();
    cashDispenser = new CashDispenser();
    bankDatabase = new BankDatabase();
  }

  void run() {
    while (true) {
      while (!userAuthenticated!) {
        screen!.displayMessage("\nWelcome to Bank of Canaman!");
        authenticateUser();
      }

      performTransactions();
      userAuthenticated = false;
      currentAccountNumber = 0;
      screen!.displayMessage("\nThank you! Have a great day!");
    }
  }

  void authenticateUser() {
    screen!.displayMessage("\nPlease enter your account number (or 0 to end simulation): ");
    int accountNumber = keypad!.getInput();

    if (accountNumber == 0) exit(0);

    screen!.displayMessage("\nPlease enter your PIN number (or 0 to end simulation): ");
    int pin = keypad!.getInput();

    if (pin == 0) exit(0);

    userAuthenticated = bankDatabase!.authenticateUser(accountNumber, pin);

    if (userAuthenticated!) {
      currentAccountNumber = accountNumber;
    } else {
      screen!.displayMessage(
          "Invalid account number or PIN number. Please try again");
    }
  }

  void performTransactions() {
    Transaction? currentTransaction = null;

    bool exited = false;

    while (!exited) {
      int mainMenuSelection = displayMainMenu();

      switch (mainMenuSelection) {
        case 1:
        case 2:
        case 3:
          currentTransaction = createTransaction(mainMenuSelection);
          currentTransaction!.execute();
          break;
        case 4:
          screen!.displayMessage("\nLogging out of account...");
          exited = true;
          break;

        default:
          screen!.displayMessage(
              "\nYou did not enter a valid selection. Try again.");
          break;
      }
    }
  }

  int displayMainMenu() {
    screen!.displayMessage("\nMain menu:");
    screen!.displayMessage("1 - View balance");
    screen!.displayMessage("2 - Withdraw cash");
    screen!.displayMessage("3 - Deposit funds");
    screen!.displayMessage("4 - Exit\n");

    return keypad!.getInput();
  }

  Transaction? createTransaction(int type) {
    Transaction? temp = null;

    switch (type) {
      case 1:
        temp =
            new BalanceInquiry(currentAccountNumber!, screen!, bankDatabase!);
        break;
      case 2:
        temp = new Withdrawal(currentAccountNumber!, screen!, bankDatabase!,
            keypad!, cashDispenser!);
        break;
      case 3:
        temp =
            new Deposit(currentAccountNumber!, screen!, bankDatabase!, keypad!);
    }

    return temp;
  }
}
