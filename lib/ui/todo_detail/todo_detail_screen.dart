import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_matrix/common/function/common_func.dart';
import 'package:todo_matrix/model/todo_model.dart';
import 'package:todo_matrix/ui/todo_make/todo_make_screen.dart';
import 'package:todo_matrix/ui/todo_make/todo_make_view_model.dart';

class TodoDetail extends ConsumerWidget {
  final selectCategory;
  final selectColor;

  const TodoDetail(this.selectCategory, this.selectColor, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _todoModel = ref.watch(todoModelProvider);
    final _todoModelNotifier = ref.watch(todoModelProvider.notifier);

    final _todoTitleTextNotifier = ref.watch(todoTitleTextProvider.notifier);

    final _todoTitleTextEditingNotifier =
        ref.watch(todoTitleTextEditingProvider.notifier);

    final _selectShowMenuCategoryNotifier =
        ref.watch(selectCategoryProvider.notifier);

    final _notificationStringDateNotifier =
        ref.watch(notificationStringDateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectCategory),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Container(
                // color: selectColor[300],
                color: isDarkMode(context) ? null : selectColor[100],
                padding: const EdgeInsets.all(10),
                // margin: const EdgeInsets.all(5),

                child: ReorderableListView(
                  onReorder: ((oldIndex, newIndex) {
                    _todoModelNotifier.replaceTodo(
                        oldIndex, newIndex, selectCategory);
                  }),
                  children: [
                    for (int index = 0; index < _todoModel.length; index += 1)
                      if (_todoModel[index].category == selectCategory)
                        Dismissible(
                          key: ValueKey(_todoModel[index]),
                          background: Container(
                            color: Colors.red,
                            child: const Icon(Icons.delete),
                          ),
                          onDismissed: (direction) {
                            _todoModelNotifier.deleteTodo(index);
                          },
                          child: Card(
                            color: isDarkMode(context)
                                ? selectColor[300]
                                : selectColor[50],
                            child: ListTile(
                              onTap: () {
                                print("Card onTap");
                                // Todoタイトル、カテゴリ、通知設定の状態を更新
                                _todoTitleTextNotifier
                                    .editTitle(_todoModel[index].title);
                                _todoTitleTextEditingNotifier
                                    .editTitle(_todoModel[index].title);
                                _selectShowMenuCategoryNotifier
                                    .edit(_todoModel[index].category);
                                _notificationStringDateNotifier
                                    .editStringDate(_todoModel[index].subTitle);
                                showModalBottomSheet<void>(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                  ),
                                  barrierColor: Colors.black.withAlpha(1),
                                  // backgroundColor: Colors.transparent,
                                  constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.9),
                                  isDismissible: true,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    print("ontap : ${index}");
                                    return TodoMake(
                                      index,
                                      selectCategory,
                                      _todoModel[index].subTitle,
                                      "",
                                    );
                                  },
                                ).then((value) {
                                  print("showDialog Close");
                                  _todoTitleTextNotifier.clear();
                                  _selectShowMenuCategoryNotifier.clear();
                                  _notificationStringDateNotifier.clear();
                                });
                              },
                              dense: true,
                              contentPadding: const EdgeInsets.only(left: 5),
                              trailing: Checkbox(
                                onChanged: (value) {
                                  print("Checkbox onChanged");
                                  _todoModelNotifier.cheaked(
                                      value!, index, selectCategory);
                                },
                                // value: _isChecked,
                                value: _todoModel[index].isChecked,
                              ),
                              title: Text(
                                _todoModel[index].title,
                                style: const TextStyle(fontSize: 16),
                              ),
                              subtitle: Text(_todoModel[index].subTitle),
                            ),
                          ),
                        ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 50,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(border: Border.all()),
                ),
              ),
              flex: 1,
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 70),
        child: FloatingActionButton(
          onPressed: () {
            // Todoタイトル、カテゴリ、通知設定の状態を更新
            _todoTitleTextEditingNotifier.clear();
            _todoTitleTextNotifier.clear();
            _selectShowMenuCategoryNotifier.edit(selectCategory);
            showModalBottomSheet<void>(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              barrierColor: Colors.black.withAlpha(1),
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9),
              isDismissible: true,
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return TodoMake(
                  "",
                  selectCategory,
                  "",
                  "",
                );
              },
            ).then((value) {
              print("showDialog Close");
              _todoTitleTextEditingNotifier.clear();
              _todoTitleTextNotifier.clear();
              _selectShowMenuCategoryNotifier.clear();
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
