import 'package:flutter_riverpod/flutter_riverpod.dart';

final isTodoCheckBoxProvider =
    StateNotifierProvider<TodoCheckBox, bool>((ref) => TodoCheckBox(false));

class TodoCheckBox extends StateNotifier<bool> {
  TodoCheckBox(bool flg) : super(flg);

  void check(bool flg) {
    if (!flg) {
      state = false;
    } else {
      state = true;
    }
  }
}
