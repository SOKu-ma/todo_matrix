import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_matrix/model/dark_mode_model.dart';

// ダークモード判定用プロバイダー
final darkModeSwitchProvider = StateNotifierProvider<DarkModeSwitch, bool>(
    ((ref) => DarkModeSwitch(false)));
