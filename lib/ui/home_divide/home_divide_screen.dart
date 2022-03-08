import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_matrix/common/common.dart';
import 'package:todo_matrix/component/todo_list_view_model.dart';
import 'package:todo_matrix/model/TodoModel.dart';
import 'package:todo_matrix/ui/home_grid/home_grid_view_model.dart';
import 'package:todo_matrix/ui/todo_detail/todo_detail_screen.dart';
import 'package:todo_matrix/ui/todo_make/todo_make_screen.dart';

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
    final _verticalText = ref.watch(verticalText);
    final _horizonalText = ref.watch(horizonalText);

    final _isChecked = ref.watch(isTodoCheckBoxProvider);
    final _isCheckedNotifier = ref.watch(isTodoCheckBoxProvider.notifier);

    final _todoModel = ref.watch(todoModelProvider);
    final _todoModelNotifier = ref.watch(todoModelProvider.notifier);

    return Container(
      margin: const EdgeInsets.all(0),
      child: Row(
        children: [
          // 緊急度（高）のラベル
          Container(
            height: double.infinity,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.25),
            child: RotatedBox(
              quarterTurns: 1,
              child: RichText(
                text: TextSpan(
                  text: _horizonalText + strHigh,
                  style: DefaultTextStyle.of(context).style,
                ),
              ),
            ),
          ),
          // 重要度（高）のラベル
          Expanded(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05),
                  child: RichText(
                    text: TextSpan(
                      text: _verticalText + strHigh,
                      style: DefaultTextStyle.of(context).style,
                    ),
                  ),
                ),
                // 第1領域
                // 重要かつ緊急のタスク
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: OpenContainer(
                          // closedColor: Colors.redAccent,
                          // openColor: Colors.redAccent,
                          // middleColor: Colors.black,
                          transitionType: ContainerTransitionType.fade,
                          closedElevation: 0,
                          transitionDuration: const Duration(milliseconds: 150),
                          closedBuilder: (context, VoidCallback action) =>
                              ListView(
                            children: [
                              // Todo0件の場合
                              for (final todo in _todoModel)
                                // 重要だが緊急でないタスク
                                // TODO 分岐方法を検討
                                if ((todo.category).toString() ==
                                    "Category.importantUrgent")
                                  Card(
                                    child: CheckboxListTile(
                                      dense: true,
                                      contentPadding:
                                          const EdgeInsets.only(left: 5),
                                      value: todo.isChecked,
                                      title: Text(
                                        todo.title,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      onChanged: (val) {},
                                    ),
                                  ),
                              _emptyTodo(context, Category.importantUrgent),
                            ],
                          ),
                          // オープン時の画面では戻る用のボタンが必要
                          openBuilder: (BuildContext c, VoidCallback action) =>
                              TodoDetail(Category.importantUrgent.name),
                          // openShape: const RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.zero),
                          tappable: true,
                        ),

                        /// -----------------------------------------------------------
                        // child: ListView(
                        //   children: [
                        //     ListTile(
                        //       leading: Hero(
                        //         tag: "aaa",
                        //         child: Text("aaa"),
                        //       ),
                        //       onTap: () {
                        //         Navigator.of(context).push(
                        //           MaterialPageRoute<void>(
                        //             builder: (BuildContext context) => Scaffold(
                        //               appBar: AppBar(
                        //                 title:
                        //                     Text(Category.importantUrgent.name),
                        //               ),
                        //               body: TodoDetail(
                        //                   Category.importantUrgent.name),
                        //             ),
                        //           ),
                        //         );
                        //       },
                        //     ),
                        //     _emptyTodo(context, Category.importantUnUrgent),
                        //   ],
                        // ),
                        /// -----------------------------------------------------------
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
                                onLongPress: () {
                                  print("第二領域長押し");
                                },
                                child: ListView(
                                  children: [
                                    // Todo0件の場合
                                    for (final todo in _todoModel)
                                      // 重要だが緊急でないタスク
                                      // TODO 分岐方法を検討
                                      if ((todo.category).toString() ==
                                          "Category.importantUnUrgent")
                                        // GestureDetector(
                                        //   child: Container(
                                        //     child: Text(todo.title),
                                        //     margin: EdgeInsets.only(bottom: 5),
                                        //     decoration: BoxDecoration(
                                        //         border: Border.all()),
                                        //   ),
                                        //   onTap: () {},
                                        // ),
                                        // Container(
                                        //   color: Colors.redAccent,
                                        //   child: ListTile(
                                        //     leading: Text(todo.title),
                                        //     trailing: Checkbox(
                                        //       value: false,
                                        //       onChanged: (val) {},
                                        //     ),
                                        //   ),
                                        // ),
                                        CheckboxListTile(
                                          dense: true,
                                          contentPadding:
                                              const EdgeInsets.only(left: 5),
                                          value: todo.isChecked,
                                          title: Text(
                                            todo.title,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          onChanged: (val) {},
                                        ),
                                    _emptyTodo(
                                        context, Category.importantUnUrgent),
                                    // TODO 詳細画面へ遷移するようのListTileも必要か？？？
                                    // _moveTodoDetail(
                                    //     context, Category.importantUnUrgent),
                                    ListTile(),
                                  ],
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
                              child: ListView(
                                children: [
                                  // Todo0件の場合
                                  for (final todo in _todoModel)
                                    // 重要だが緊急でないタスク
                                    // TODO 分岐方法を検討
                                    if ((todo.category).toString() ==
                                        "Category.unImportantUrgent")
                                      CheckboxListTile(
                                        dense: true,
                                        contentPadding:
                                            const EdgeInsets.only(left: 5),
                                        value: todo.isChecked,
                                        title: Text(
                                          todo.title,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        onChanged: (val) {},
                                      ),
                                  _emptyTodo(
                                      context, Category.unImportantUrgent),
                                ],
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
                              child: ListView(
                                children: [
                                  for (final todo in _todoModel)
                                    // 重要だが緊急でないタスク
                                    // TODO 分岐方法を検討
                                    if ((todo.category).toString() ==
                                        "Category.unImportantUnUrgent")
                                      CheckboxListTile(
                                        dense: true,
                                        contentPadding:
                                            const EdgeInsets.only(left: 5),
                                        value: todo.isChecked,
                                        title: Text(
                                          todo.title,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        onChanged: (val) {},
                                      ),
                                  _emptyTodo(
                                      context, Category.unImportantUnUrgent),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // 重要度（低）ラベル
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: _verticalText + strLow,
                      style: DefaultTextStyle.of(context).style,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 緊急度（低）ラベル
          RotatedBox(
            quarterTurns: 1,
            child: RichText(
              text: TextSpan(
                text: _horizonalText + strLow,
                style: DefaultTextStyle.of(context).style,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // TODO 後で消す？？？
  _emptyTodo(BuildContext context, Category category) {
    return ListTile(
      title: const Text("＋ タスクを追加", style: TextStyle(fontSize: 16)),
      // leading: const Icon(Icons.add, size: 20),
      dense: true,
      contentPadding: const EdgeInsets.only(left: 5),
      onTap: () async {
        await showModalBottomSheet<void>(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          barrierColor: Colors.black.withAlpha(1),
          backgroundColor: Colors.white,
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.95),
          isDismissible: true,
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return TodoMake();
          },
        );
      },
    );
  }

  // TODO 詳細画面へ遷移するようのリストも追加する？？？
  // ListViewがいっぱいになると遷移できなくなる可能性がある
  _moveTodoDetail() {}
}
