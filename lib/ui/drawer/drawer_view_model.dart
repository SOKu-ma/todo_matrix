import 'package:flutter_riverpod/flutter_riverpod.dart';

final darkModeSwitchProvider = StateNotifierProvider<DarkModeSwitch, bool>(
    ((ref) => DarkModeSwitch(false)));

class DarkModeSwitch extends StateNotifier<bool> {
  DarkModeSwitch(state) : super(state);

  // ダークモード切替
  void change(bool value) {
    if (!value) {
      state = false;
    } else {
      state = true;
    }
  }
}
