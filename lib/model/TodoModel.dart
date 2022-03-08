import 'package:flutter_riverpod/flutter_riverpod.dart';

// TodoモデルProvider
final todoModelProvider =
    StateNotifierProvider<TodoModelNotifier, List<TodoModel>>((ref) {
  return TodoModelNotifier([]);
});

class TodoModelNotifier extends StateNotifier<List<TodoModel>> {
  TodoModelNotifier(List<TodoModel> state) : super(state);

  // Todo追加メソッド
  void add(TodoModel todo) {
    // ドット3つでStateにtodoをappendしてくれる
    state = [...state, todo];
  }

  // Todo削除メソッド
  void delete(TodoModel todo) {
    //
  }

  // Todoカテゴリー変更メソッド
  void selectCategory(TodoModel todo) {
    //
  }

  // Todoのチェック切替メソッド
  void cheak(TodoModel todo) {
    //
  }

  void countCategory(TodoModel tpdo) {
    //
  }
}

// Todoモデル
class TodoModel {
  String title;
  // String subTitle;
  bool isChecked;
  var category;

  TodoModel(
    this.title,
    // this.subTitle,
    this.isChecked,
    this.category,
  );
}

// Todoモデルをリストで管理
class TodoListModel {
  List<TodoModel> todoListModel = [];
}
