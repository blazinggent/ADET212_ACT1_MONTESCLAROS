// A simulation program for Automated Teller Machine (ATM)
// by Ian Montesclaros

import 'ATM.dart';

void main() {
  // test account 1 - account number 12345, pin number 54321
  // test account 2 - account number 98765, pin number 56789
  ATM simulation = new ATM();
  simulation.run();
}
