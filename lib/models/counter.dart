import 'package:flutter/material.dart';

class CounterModel extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    if (_counter < 99) { // Limita o contador a 99
      _counter++;
      notifyListeners(); // Notifica os ouvintes sobre a mudança
    }
  }

  void decrement() {
    if (_counter > 0) { // Impede que o contador fique abaixo de 0
      _counter--;
      notifyListeners(); // Notifica os ouvintes sobre a mudança
    }
  }
}
