import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_matrix/model/TodoModel.dart';

enum Category {
  importantUrgent, // 第1領域 緊急かつ重要
  importantUnUrgent, // 第2領域 緊急でないが重要
  unImportantUrgent, // 第3領域 重要でないが緊急
  unImportantUnUrgent, // 第4領域 緊急でないかつ重要でない
}

final textTitleController = TextEditingController();
final textSubTitleController = TextEditingController();

class TodoMake extends ConsumerWidget {
  const TodoMake({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _selected = ref.watch(selectCategoryProvider);
    final _selectedNotifier = ref.watch(selectCategoryProvider.notifier);

    final _todoModel = ref.watch(todoModelProvider);
    final _todoModelNotifier = ref.watch(todoModelProvider.notifier);

    return Column(
      children: [
        const SizedBox(height: 30),
        Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
          child: TextField(
            decoration: const InputDecoration(hintText: "タスクを追加"),
            controller: textTitleController,
          ),
        ),
        // Container(
        //   margin:
        //       const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
        //   child: TextField(
        //     decoration: const InputDecoration(hintText: "タスクの詳細を追加"),
        //     controller: textSubTitleController,
        //   ),
        // ),
        const SizedBox(height: 30),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 25),
          child: const Text("カテゴリを選択", style: TextStyle(fontSize: 18)),
        ),
        RadioListTile(
          title: const Text("第１領域 : 緊急かつ重要なタスク"),
          value: Category.importantUrgent,
          groupValue: _selected,
          onChanged: (val) {
            _selectedNotifier.select(val);
          },
        ),
        RadioListTile(
          title: const Text("第２領域 : 重要だが緊急でないなタスク"),
          value: Category.importantUnUrgent,
          groupValue: _selected,
          onChanged: (val) {
            _selectedNotifier.select(val);
          },
        ),
        RadioListTile(
          title: const Text("第３領域 : 緊急だが重要でないタスク"),
          value: Category.unImportantUrgent,
          groupValue: _selected,
          onChanged: (val) {
            _selectedNotifier.select(val);
          },
        ),
        RadioListTile(
          title: const Text("第４領域 : 緊急でなく重要でないタスク"),
          value: Category.unImportantUnUrgent,
          groupValue: _selected,
          onChanged: (val) {
            _selectedNotifier.select(val);
          },
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: 140,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              // Todoモデルに保存
              TodoModel _todo = TodoModel(textTitleController.text,
                  textSubTitleController.text, false, _selected);
              _todoModelNotifier.add(_todo);
              Navigator.of(context, rootNavigator: true).pop(context);
            },
            child: const Text("保存", style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }
}
