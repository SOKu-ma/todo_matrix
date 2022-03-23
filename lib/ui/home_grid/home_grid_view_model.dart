import 'package:flutter_riverpod/flutter_riverpod.dart';

final isCheckedProvider =
    StateNotifierProvider<TodoCheckBox, bool>((ref) => TodoCheckBox(false));

class TodoCheckBox extends StateNotifier<bool> {
  TodoCheckBox(bool flg) : super(flg);

  void checked(bool flg) {
    if (!flg) {
      state = false;
    } else {
      state = true;
    }
  }
}

final verticalTextProvider = StateProvider((ref) => '重要');
final horizonalTextProvider = StateProvider((ref) => '緊急');
final denaialTextProvider = StateProvider((ref) => 'でない');
