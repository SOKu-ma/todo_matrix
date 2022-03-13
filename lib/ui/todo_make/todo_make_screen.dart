import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_matrix/model/TodoModel.dart';
import 'package:todo_matrix/ui/todo_make/todo_make_view_model.dart';

enum Category {
  importantUrgent, // 第1領域 緊急かつ重要
  importantUnUrgent, // 第2領域 緊急でないが重要
  unImportantUrgent, // 第3領域 重要でないが緊急
  unImportantUnUrgent, // 第4領域 緊急でないかつ重要でない
}

final _formKey = GlobalKey<FormState>();

class TodoMake extends ConsumerWidget {
  const TodoMake({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _selected = ref.watch(selectCategoryProvider);
    final _selectedNotifier = ref.watch(selectCategoryProvider.notifier);

    final _todoModel = ref.watch(todoModelProvider);
    final _todoModelNotifier = ref.watch(todoModelProvider.notifier);

    final _todoTitle = ref.watch(todoTitleProvider);
    final _todoTitleNotifier = ref.watch(todoTitleProvider.notifier);

    return Column(
      children: [
        const SizedBox(height: 30),
        Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
          child: TextFormField(
            decoration: const InputDecoration(hintText: "タスクを追加"),
            controller: _todoTitle,
            key: _formKey,
            validator: (value) {
              if (value == "") {
                // return 'タスクを入力してください';
                Navigator.of(context, rootNavigator: true).pop(context);
              }
              return null;
            },
            onChanged: (value) {
              print("onChangeイベント：" + value);
            },
            onSaved: (value) {
              print("onSaveイベント：" + value!);
            },
            onFieldSubmitted: (value) {
              print("onFieldSubmittedイベント：" + value);
            },
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 25),
          child: const Text("カテゴリを選択", style: TextStyle(fontSize: 18)),
        ),

        // ----------------------------------------------
        // Container(
        //   margin: const EdgeInsets.only(left: 20, right: 20),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: Container(
        //           child: RadioListTile(
        //             title: const Text("重要"),
        //             value: Category.importantUrgent,
        //             groupValue: _selected,
        //             onChanged: (val) {
        //               _selectedNotifier.select(val);
        //             },
        //           ),
        //         ),
        //       ),
        //       Expanded(
        //         child: RadioListTile(
        //           title: const Text("重要でない"),
        //           value: Category.importantUnUrgent,
        //           groupValue: _selected,
        //           onChanged: (val) {
        //             _selectedNotifier.select(val);
        //           },
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // ----------------------------------------------

        // ----------------------------------------------
        // Container(
        //   margin: const EdgeInsets.only(left: 20, right: 20),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: Container(
        //           child: ToggleButtons(children: []),
        //         ),
        //       ),
        //       Expanded(
        //         child: RadioListTile(
        //           title: const Text("重要でない"),
        //           value: Category.importantUnUrgent,
        //           groupValue: _selected,
        //           onChanged: (val) {
        //             _selectedNotifier.select(val);
        //           },
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // ----------------------------------------------

        // ----------------------------------------------
        RadioListTile(
          title: const Text(
            "第１領域 : 緊急かつ重要なタスク",
            style: TextStyle(fontSize: 15),
          ),
          value: Category.importantUrgent,
          groupValue: _selected,
          onChanged: (val) {
            _selectedNotifier.select(val);
          },
        ),
        RadioListTile(
          title: const Text(
            "第２領域 : 重要だが緊急でないなタスク",
            style: TextStyle(fontSize: 15),
          ),
          value: Category.importantUnUrgent,
          groupValue: _selected,
          onChanged: (val) {
            _selectedNotifier.select(val);
          },
        ),
        RadioListTile(
          title: const Text(
            "第３領域 : 緊急だが重要でないタスク",
            style: TextStyle(fontSize: 15),
          ),
          value: Category.unImportantUrgent,
          groupValue: _selected,
          onChanged: (val) {
            _selectedNotifier.select(val);
          },
        ),
        RadioListTile(
          title: const Text(
            "第４領域 : 緊急でなく重要でないタスク",
            style: TextStyle(fontSize: 15),
          ),
          value: Category.unImportantUnUrgent,
          groupValue: _selected,
          onChanged: (val) {
            _selectedNotifier.select(val);
          },
        ),
        // ----------------------------------------------

        const SizedBox(height: 30),
        SizedBox(
          width: 140,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              // テキストnullチェック
              if (_todoTitleNotifier.brankCheck(_todoTitle) != null) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text(
                      "タスクを入力してください",
                      style: TextStyle(fontSize: 14),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(context);
                          },
                          child: const Text("OK"))
                    ],
                  ),
                );
                return;
                // Navigator.of(context, rootNavigator: true).pop(context);
              }
              // Todoモデルに保存
              TodoModel _todo = TodoModel(_todoTitle.text, false, _selected);
              _todoModelNotifier.add(_todo);
              _todoTitle.text = "";
              Navigator.of(context, rootNavigator: true).pop(context);
            },
            child: const Text("保存", style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }
}
