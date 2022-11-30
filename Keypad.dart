import 'dart:io';

class Keypad {
  String? input;

  Keypad() {
    input = '';
  }

  int getInput() {
    input = stdin.readLineSync();

    return int.parse(input!);
  }
}
