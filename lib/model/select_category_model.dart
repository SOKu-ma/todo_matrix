import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO 修正したい。。。
const defImpUrgText = "重要度・緊急度";
const ImportantUrgent = "第１領域 : 緊急かつ重要";
const ImportantUnUrgent = "第２領域 : 緊急でないが重要";
const UnImportantUrgent = "第３領域 : 緊急だが重要でない";
const UnImportantUnUrgent = "第４領域 : 緊急でも重要でもない";

enum Category {
  importantUrgent, // 第1領域 緊急かつ重要
  importantUnUrgent, // 第2領域 緊急でないが重要
  unImportantUrgent, // 第3領域 重要でないが緊急
  unImportantUnUrgent, // 第4領域 緊急でないかつ重要でない
}

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

  void edit(String category) {
    state = category;
  }

  // 選択カテゴリーをクリア
  void clear() {
    state = defImpUrgText;
  }
}
