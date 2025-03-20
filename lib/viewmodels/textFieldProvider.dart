import 'package:flutter/cupertino.dart';

class TextFieldProvider extends ChangeNotifier {
  String _text = "";

  String get text => _text;

  void updateText(String newText) {
    _text = newText;
    notifyListeners();
  }

  void clearText() {
    _text = "";
    notifyListeners();
  }
}
