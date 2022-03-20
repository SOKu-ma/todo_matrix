import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// アプリカラーテーマ
final appColorProvider = StateProvider((ref) => Colors.green);

TimeOfDay? selectedTime;

Future pickTime(BuildContext context) async {
  final initialTime = TimeOfDay(hour: 10, minute: 0);

  //TimePickerを呼び出す
  final newTime =
      await showTimePicker(context: context, initialTime: initialTime);

  //nullチェック
  if (newTime != null) {
    //変数に選択した時刻を格納
    // setState(() => selectedTime = newTime);
  } else {
    return;
  }
}
