import 'package:flutter/foundation.dart';

class DropdownProvider with ChangeNotifier {
  String? _selectedDrink;
  String? get selectedDrink => this._selectedDrink;
  set selectedDrink(String? s) => throw "error";

  final List<String> _drinks = [
    "Orange Juice",
    "Coca Cola",
    "Sparkling Water",
    "Ice Peach Tea",
    "Chocolate Milk",
  ];
  List<String> get drinks => [...this._drinks];
  set drinks(List<String> l) => throw "error";

  void changeDrink(String s){
    this._selectedDrink = s;
    this.notifyListeners();
  }
}