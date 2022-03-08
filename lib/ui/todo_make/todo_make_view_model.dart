import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_matrix/ui/todo_make/todo_make_screen.dart';

// カテゴリー選択用Provider
final selectCategoryProvider = StateNotifierProvider(
  (ref) => SelectCategoryNotifier(Category.importantUrgent),
);

class SelectCategoryNotifier extends StateNotifier<Category> {
  SelectCategoryNotifier(state) : super(state);

  // カテゴリー切替
  select(var category) {
    switch (category) {
      case Category.importantUrgent:
        state = Category.importantUrgent;
        break;
      case Category.importantUnUrgent:
        state = Category.importantUnUrgent;
        break;
      case Category.unImportantUrgent:
        state = Category.unImportantUrgent;
        break;
      case Category.unImportantUnUrgent:
        state = Category.unImportantUnUrgent;
        break;
      default:
        break;
    }
  }
}

// Todoタイトル用Provider
final textTitleController = TextEditingController();
final todoTitleProvider =
    StateNotifierProvider<TodoTitleNotifier, TextEditingController>(
  (ref) => TodoTitleNotifier(TextEditingController()),
);

class TodoTitleNotifier extends StateNotifier<TextEditingController> {
  TodoTitleNotifier(TextEditingController state) : super(state);

  brankCheck(TextEditingController val) {
    if (val.text == "") {
      return "TODOタスクが入力されていません";
    }
    return null;
  }
}
