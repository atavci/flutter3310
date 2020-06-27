import 'package:flutter/cupertino.dart';

class DialerModel extends ChangeNotifier {
  var number = '';

  void append(String no) {
    number += no;
    print(number);
    notifyListeners();
  }

  void delete() {
    number = number.substring(0, number.length - 1);
    notifyListeners();
  }

  void clear() {
    number = '';
    notifyListeners();
  }
}
