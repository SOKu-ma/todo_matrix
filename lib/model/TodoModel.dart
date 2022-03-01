import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_matrix/ui/todo_make/todo_make_screen.dart';

// カテゴリー選択用Provider
final selectCategoryProvider = StateNotifierProvider(
  (ref) => SelectCategoryNotifier(Category.importantUrgent),
);

class SelectCategoryNotifier extends StateNotifier<Category> {
  SelectCategoryNotifier(state) : super(state);

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

// TodoモデルProvider
final todoModelProvider =
    StateNotifierProvider<TodoModelNotifier, List<TodoModel>>((ref) {
  return TodoModelNotifier([]);
});

class TodoModelNotifier extends StateNotifier<List<TodoModel>> {
  TodoModelNotifier(List<TodoModel> state) : super(state);

  void add(TodoModel todo) {
    // ドット3つでStateにtodoをappendしてくれる
    state = [...state, todo];
  }

  void delete(TodoModel todo) {
    //
  }

  void selectCategory(TodoModel todo) {
    //
  }

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
  String subTitle;
  bool isChecked;
  var category;

  TodoModel(this.title, this.subTitle, this.isChecked, this.category);
}

// Todoモデルをリストで管理
class TodoListModel {
  List<TodoModel> todoListModel = [];
}
