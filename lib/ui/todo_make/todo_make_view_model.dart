import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_matrix/model/notification_string_date_model.dart';
import 'package:todo_matrix/model/select_category_model.dart';

// カテゴリー選択用Provider
final selectCategoryProvider =
    StateNotifierProvider<SelectCategoryNotifier, String>(
  (ref) => SelectCategoryNotifier(defImpUrgText),
);

//
final todoTitleTextProvider =
    StateNotifierProvider<TodoTitleTextNotifier, String>(
  (ref) => TodoTitleTextNotifier(""),
);

class TodoTitleTextNotifier extends StateNotifier<String> {
  TodoTitleTextNotifier(String state) : super(state);

  // テキストを編集
  void editTitle(String text) {
    state = text;
  }

  void clear() {
    state = "";
  }
}

// Todoタイトル用Provider（TextEditingController）
final todoTitleTextEditingProvider =
    StateNotifierProvider<TodoTitleNotifier, TextEditingController>(
  (ref) => TodoTitleNotifier(TextEditingController()),
);

class TodoTitleNotifier extends StateNotifier<TextEditingController> {
  TodoTitleNotifier(TextEditingController state) : super(state);

  // テキストを編集
  editTitle(String value) {
    state.text = value;
  }

  // テキストクリア
  void clear() {
    state.text = "";
  }

  // ブランクチェック
  brankCheck(TextEditingController val) {
    if (val.text == "") {
      return "TODOタスクが入力されていません";
    }
    return null;
  }
}

// 通知設定用(String)
final notificationStringDateProvider =
    StateNotifierProvider<NoticicationStringDate, String>(
        (ref) => NoticicationStringDate(NotifiDefDate));

// 通知設定用(DateTime)
final notificationDateProvider = StateProvider((ref) => DateTime.now());

// Todoタスク並び順用
final todoOrderProvider = StateProvider((ref) => 1);
