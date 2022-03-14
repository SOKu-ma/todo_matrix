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

  // Todo並べ替えメソッド
  void replace(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final _todo = state.removeAt(oldIndex);
    state.insert(newIndex, _todo);
    state = [for (final todo in state) todo];
  }

  // Todo削除メソッド
  void delete(TodoModel todo) {}

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
  // int id;
  String title;
  // String subTitle;
  bool isChecked;
  var category;

  TodoModel(
    // this.id,
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
