class CashDispenser {
  static final int INITIAL_COUNT = 500;
  int count = 0;

  CashDispenser() {
    count = INITIAL_COUNT;
  }

  void dispenseCash(int amount) {
    int billsRequired = (amount / 100).floor();
    count -= billsRequired;
  }

  bool isSufficientCashAvailable(int amount) {
    int billsRequired = (amount / 100).floor();

    if (count >= billsRequired) {
      return true;
    } else {
      return false;
    }
  }
}
