import 'package:flutter_riverpod/flutter_riverpod.dart';

// TodoモデルProvider
final todoModelProvider =
    StateNotifierProvider<TodoModelNotifier, List<TodoModel>>((ref) {
  return TodoModelNotifier([]);
});

class TodoModelNotifier extends StateNotifier<List<TodoModel>> {
  TodoModelNotifier(List<TodoModel> state) : super(state);

  // Todo追加メソッド
  void addTodo(TodoModel todo) {
    // ドット3つでStateにtodoをappendしてくれる
    state = [...state, todo];
  }

  // Todo編集メソッド
  /// 対象のTodoを検索
  /// Title,Category,notificationDateを書き換え
  void editTodo(int index, String title, String category, String subTitle) {
    List<TodoModel> _state = [];
    for (final _todo in state) {
      if (_todo.category == category) {
        if (_todo.order == index + 1) {
          _todo.title = title;
          _todo.category = category;
          _todo.subTitle = subTitle;
        }
      }
      _state = [..._state, _todo];
    }
    state = _state;
  }

  // Todo並べ替えメソッド
  void replaceTodo(int oldIndex, int newIndex, String category) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    // 対象のカテゴリのみのリストを作成
    List<TodoModel> _state = state;

    // 対象のカテゴリのリストで並べ替え
    _state = [
      for (final todo in _state)
        if (todo.category == category) todo
    ];

    final _todo = state.removeAt(oldIndex);
    state.insert(newIndex, _todo);
    state = [for (final todo in state) todo];
  }

  // Todo削除メソッド
  void deleteTodo(int index) {
    state.removeAt(index);
    state = [for (final todo in state) todo];
  }

  // Todoのチェック切替メソッド
  void cheaked(bool value, int index, String category) {
    List<TodoModel> _state = [];
    for (final _todo in state) {
      if (_todo.category == category) {
        if (_todo.order == index + 1) {
          _todo.isChecked = value;
        }
        _state = [..._state, _todo];
      }
      state = _state;
    }
  }
}

// Todoモデル
class TodoModel {
  // int id;
  String title;
  String subTitle;
  bool isChecked;
  var category;
  int order;
  DateTime createDate;
  DateTime updateDate;

  TodoModel(
    // this.id,
    this.title,
    this.subTitle,
    this.isChecked,
    this.category,
    this.order,
    this.createDate,
    this.updateDate,
  );
}

// Todoモデルをリストで管理
class TodoListModel {
  List<TodoModel> todoListModel = [];
}
