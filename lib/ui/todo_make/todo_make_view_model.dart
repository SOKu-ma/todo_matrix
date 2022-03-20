import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Category {
  importantUrgent, // 第1領域 緊急かつ重要
  importantUnUrgent, // 第2領域 緊急でないが重要
  unImportantUrgent, // 第3領域 重要でないが緊急
  unImportantUnUrgent, // 第4領域 緊急でないかつ重要でない
}

// カテゴリー選択用Provider
final selectCategoryProvider =
    StateNotifierProvider<SelectCategoryNotifier, String>(
  (ref) => SelectCategoryNotifier(defImpUrgText),
);

class SelectCategoryNotifier extends StateNotifier<String> {
  SelectCategoryNotifier(String state) : super(state);

  // カテゴリー切替
  select(Category category) {
    switch (category) {
      case Category.importantUrgent:
        state = ImportantUrgent;
        break;
      case Category.importantUnUrgent:
        state = ImportantUnUrgent;
        break;
      case Category.unImportantUrgent:
        state = UnImportantUrgent;
        break;
      case Category.unImportantUnUrgent:
        state = UnImportantUnUrgent;
        break;
      default:
        break;
    }
  }

  // 選択カテゴリーをクリア
  clear(String category) {
    state = defImpUrgText;
  }
}

// TODO 修正したい。。。
const defImpUrgText = "重要度・緊急度";
const ImportantUrgent = "第１領域 : 緊急かつ重要";
const ImportantUnUrgent = "第２領域 : 緊急でないが重要";
const UnImportantUrgent = "第３領域 : 緊急だが重要でない";
const UnImportantUnUrgent = "第４領域 : 緊急でも重要でもない";

// // カテゴリー選択用（メニュー）
// final selectShowMenuCategoryProvider =
//     StateNotifierProvider<SelectShowMenuCategoryNotifier, String>(
//         (ref) => SelectShowMenuCategoryNotifier(defImpUrgText));

// class SelectShowMenuCategoryNotifier extends StateNotifier<String> {
//   SelectShowMenuCategoryNotifier(state) : super(state);

//   // カテゴリー切替
//   select(String category) {
//     switch (category) {
//       case ImportantUrgent:
//         state = ImportantUrgent;
//         break;
//       case ImportantUnUrgent:
//         state = ImportantUnUrgent;
//         break;
//       case UnImportantUrgent:
//         state = UnImportantUrgent;
//         break;
//       case UnImportantUnUrgent:
//         state = UnImportantUnUrgent;
//         break;
//       default:
//         break;
//     }
//   }

//   // 選択カテゴリーをクリア
//   clear(String category) {
//     state = defImpUrgText;
//   }
// }

//
final todoTitleTextNotifier =
    StateNotifierProvider<TodoTitleTextNotifier, String>(
  (ref) => TodoTitleTextNotifier(""),
);

class TodoTitleTextNotifier extends StateNotifier<String> {
  TodoTitleTextNotifier(String state) : super(state);

  // テキストを編集
  void editTitle(String text) {
    state = text;
  }
}

// Todoタイトル用Provider（TextEditingController）
final textTitleController = TextEditingController();
final todoTitleProvider =
    StateNotifierProvider<TodoTitleNotifier, TextEditingController>(
  (ref) => TodoTitleNotifier(TextEditingController()),
);

class TodoTitleNotifier extends StateNotifier<TextEditingController> {
  TodoTitleNotifier(TextEditingController state) : super(state);

  // テキストを編集
  editTitle(String text) {
    state.text = text;
  }

  // ブランクチェック
  brankCheck(TextEditingController val) {
    if (val.text == "") {
      return "TODOタスクが入力されていません";
    }
    return null;
  }
}

const NotifiDate = "通知なし";
final notificationDate = StateNotifierProvider<NoticicationDate, String>(
    (ref) => NoticicationDate(NotifiDate));

class NoticicationDate extends StateNotifier<String> {
  NoticicationDate(String state) : super(state);
}
