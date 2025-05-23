import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

final change = ChangeNotifierProvider((ref) => Countchanger());
final state = StateProvider((ref) => 0);

class Countchanger extends ChangeNotifier {
  int number = 3;
  void addNum() {
    number++;
    notifyListeners();
  }

  void subNum() {
    number--;
    notifyListeners();
  }
}
