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
  void editTodo(TodoModel todo) {
    List<TodoModel> _state = [];
    for (final _todo in state) {
      if (_todo.id == todo.id) {
        _todo.title = todo.title;
        _todo.category = todo.category;
        _todo.subTitle = todo.subTitle;
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
  void cheaked(bool value, int id) {
    List<TodoModel> _state = [];
    for (final _todo in state) {
      if (_todo.id == id) {
        _todo.isChecked = value;
      }
      _state = [..._state, _todo];
    }
    state = _state;
  }

  // // Todoカテゴリー変更メソッド
  // void selectCategory(TodoModel todo) {
  //   //
  // }
  // void countCategory(TodoModel tpdo) {
  //   //
  // }
}

// TODO 暫定のID
// TODO 後ほどランダム生成されるIDに修正
int countID = 100;

// Todoモデル
class TodoModel {
  int id;
  String title;
  String subTitle;
  String? limitDate;
  bool isChecked;
  var category;
  int order;
  DateTime createDate;
  DateTime updateDate;

  TodoModel(
    this.id,
    this.title,
    this.subTitle,
    this.limitDate,
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
