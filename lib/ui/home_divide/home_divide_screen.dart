import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_matrix/common/function/common_func.dart';
import 'package:todo_matrix/component/todo_list_view_model.dart';
import 'package:todo_matrix/model/select_category_model.dart';
import 'package:todo_matrix/model/todo_model.dart';
import 'package:todo_matrix/ui/home_divide/home_divide_view_model.dart';
import 'package:todo_matrix/ui/home_grid/home_grid_view_model.dart';
import 'package:todo_matrix/ui/todo_detail/todo_detail_screen.dart';
import 'package:todo_matrix/ui/todo_make/todo_make_view_model.dart';

enum Category {
  importantUrgent, // 第1領域 緊急かつ重要
  importantUnUrgent, // 第2領域 緊急でないが重要
  unImportantUrgent, // 第3領域 重要でないが緊急
  unImportantUnUrgent, // 第4領域 緊急でないかつ重要でない
}

class HomeDivide extends ConsumerWidget {
  const HomeDivide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _verticalText = ref.watch(verticalTextProvider);
    final _horizonalText = ref.watch(horizonalTextProvider);
    final _denaialText = ref.watch(denaialTextProvider);

    final _impUrgColor = ref.watch(impUrgColorProvider);
    final _impUnUrgColor = ref.watch(impUnUrgColorProvider);
    final _unImpUrgColor = ref.watch(unImpUrgColorProvider);
    final _unImpUnUrgColor = ref.watch(unImpUnUrgColorProvider);

    final _isChecked = ref.watch(isTodoCheckBoxProvider);
    final _isCheckedNotifier = ref.watch(isTodoCheckBoxProvider.notifier);

    final _todoModel = ref.watch(todoModelProvider);
    final _todoModelNotifier = ref.watch(todoModelProvider.notifier);

    return Container(
      margin: const EdgeInsets.all(0),
      child: Column(
        children: [
          Expanded(
            flex: 9,
            child: Row(
              children: [
                // -- 1列目 START --
                Column(
                  children: [
                    // 「緊急」のラベル
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.25),
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: [
                                TextSpan(
                                  text: _horizonalText,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // 「緊急でない」のラベル
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.25),
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: RichText(
                            text: TextSpan(
                              // text: _horizonalText + _denaialText,
                              style: DefaultTextStyle.of(context).style,
                              children: [
                                TextSpan(
                                  text: _horizonalText + _denaialText,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // -- 1列目 END --

                // -- 2列目 START --
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // 「重要」のラベル
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.15),
                              child: RichText(
                                text: TextSpan(
                                    // text: _verticalText,
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                      TextSpan(
                                        text: _verticalText,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                          // 「重要」のラベル
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.15),
                              child: RichText(
                                text: TextSpan(
                                    // text: _verticalText + _denaialText,
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                      TextSpan(
                                        text: _verticalText + _denaialText,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // 第1領域
                      // 重要かつ緊急のタスク
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          TodoDetail(
                                              ImportantUrgent, _impUrgColor),
                                    ),
                                  );
                                },
                                child: Container(
                                  color: isDarkMode(context)
                                      ? null
                                      : _impUrgColor[100],
                                  child: ListView(
                                    children: [
                                      // Todo0件の場合
                                      for (final todo in _todoModel)
                                        // 重要かつ緊急なタスク
                                        // TODO 分岐方法を検討
                                        if (todo.category == ImportantUrgent)
                                          Card(
                                            color: isDarkMode(context)
                                                ? _impUrgColor[300]
                                                : _impUrgColor[50],
                                            child: CheckboxListTile(
                                              dense: true,
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 5),
                                              value: todo.isChecked,
                                              title: Text(todo.title,
                                                  style: const TextStyle(
                                                      fontSize: 16)),
                                              onChanged: (val) {},
                                            ),
                                          ),
                                      // _emptyTodo(
                                      //     context, Category.importantUrgent),
                                      const ListTile(
                                        leading: Text(""),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const VerticalDivider(
                                color: Colors.grey, indent: 0, thickness: 2),
                            // 第2領域
                            // 重要だが緊急でない
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                TodoDetail(ImportantUnUrgent,
                                                    _impUnUrgColor),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        color: isDarkMode(context)
                                            ? null
                                            : _impUnUrgColor[100],
                                        // color: _impUnUrgColor[100],
                                        child: ListView(
                                          children: [
                                            // Todo0件の場合
                                            for (final todo in _todoModel)
                                              // 重要だが緊急でないタスク
                                              // TODO 分岐方法を検討
                                              if (todo.category ==
                                                  ImportantUnUrgent)
                                                Card(
                                                  color: isDarkMode(context)
                                                      ? _impUnUrgColor[300]
                                                      : _impUnUrgColor[50],
                                                  child: CheckboxListTile(
                                                    dense: true,
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    value: todo.isChecked,
                                                    title: Text(
                                                      todo.title,
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    onChanged: (val) {},
                                                  ),
                                                ),
                                            // _emptyTodo(context,
                                            //     Category.importantUnUrgent),
                                            const ListTile(
                                              leading: Text(""),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 2,
                      ),
                      // 第3領域
                      // 重要でないが緊急のタスク
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                TodoDetail(UnImportantUrgent,
                                                    _unImpUrgColor),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        color: isDarkMode(context)
                                            ? null
                                            : _unImpUrgColor[100],
                                        // color: _unImpUrgColor[100],
                                        child: ListView(
                                          children: [
                                            // Todo0件の場合
                                            for (final todo in _todoModel)
                                              // 重要でないが緊急なタスク
                                              // TODO 分岐方法を検討
                                              if (todo.category ==
                                                  UnImportantUrgent)
                                                Card(
                                                  color: isDarkMode(context)
                                                      ? _unImpUrgColor[300]
                                                      : _unImpUrgColor[50],
                                                  child: CheckboxListTile(
                                                    dense: true,
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    value: todo.isChecked,
                                                    title: Text(
                                                      todo.title,
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    onChanged: (val) {},
                                                  ),
                                                ),
                                            // _emptyTodo(context,
                                            //     Category.unImportantUrgent),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const VerticalDivider(
                                color: Colors.grey, endIndent: 0, thickness: 2),
                            // 第4領域
                            // 重要でなく緊急でもないのタスク
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                TodoDetail(UnImportantUnUrgent,
                                                    _unImpUnUrgColor),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        color: isDarkMode(context)
                                            ? null
                                            : _unImpUnUrgColor[100],
                                        child: ListView(
                                          children: [
                                            for (final todo in _todoModel)
                                              // 重要でも緊急でもないタスク
                                              // TODO 分岐方法を検討
                                              if (todo.category ==
                                                  UnImportantUnUrgent)
                                                Card(
                                                  color: isDarkMode(context)
                                                      ? _unImpUnUrgColor[300]
                                                      : _unImpUnUrgColor[50],
                                                  child: CheckboxListTile(
                                                    dense: true,
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    value: todo.isChecked,
                                                    title: Text(
                                                      todo.title,
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    onChanged: (val) {},
                                                  ),
                                                ),
                                            // _emptyTodo(context,
                                            //     Category.unImportantUnUrgent),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5)
                // -- 2列目 END --
              ],
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            flex: 1,
            child: Container(
              height: 50,
              decoration: BoxDecoration(border: Border.all()),
              // color: Colors.purple[100],
            ),
          ),
        ],
      ),
    );
  }

  // // Todoリストのカード
  // _todoCard(MaterialColor color) {
  //   return Card(
  //     color: color[50],
  //     // color: _impUrgColor[300],
  //     child: CheckboxListTile(
  //       dense: true,
  //       contentPadding: const EdgeInsets.only(left: 5),
  //       value: false,
  //       // value: todo.isChecked,
  //       // title: Text(todo.title, style: const TextStyle(fontSize: 16)),
  //       onChanged: (val) {},
  //     ),
  //   );
  // }

  // // TODO 後で消す？？？
  // _emptyTodo(BuildContext context, Category category) {
  //   return ListTile(
  //     title: const Text("＋ タスクを追加", style: TextStyle(fontSize: 16)),
  //     // leading: const Icon(Icons.add, size: 20),
  //     dense: true,
  //     contentPadding: const EdgeInsets.only(left: 5),
  //     onTap: () async {
  //       await showModalBottomSheet<void>(
  //         shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //         ),
  //         barrierColor: Colors.black.withAlpha(1),
  //         constraints: BoxConstraints(
  //             maxHeight: MediaQuery.of(context).size.height * 0.9),
  //         isDismissible: true,
  //         isScrollControlled: true,
  //         context: context,
  //         builder: (BuildContext context) {
  //           return TodoMake();
  //         },
  //       );
  //     },
  //   );
  // }

  // TODO 詳細画面へ遷移するようのリストも追加する？？？
  // ListViewがいっぱいになると遷移できなくなる可能性がある
  // _moveTodoDetail() {}
}
