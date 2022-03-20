import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_matrix/model/TodoModel.dart';
import 'package:todo_matrix/ui/todo_make/todo_make_screen.dart';
import 'package:todo_matrix/ui/todo_make/todo_make_view_model.dart';

class TodoDetail extends ConsumerWidget {
  final selectCategory;
  final selectColor;

  TodoDetail(this.selectCategory, this.selectColor, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _todoModel = ref.watch(todoModelProvider);
    final _todoModelNotifier = ref.watch(todoModelProvider.notifier);

    final _todoTitle = ref.watch(todoTitleProvider);
    final _todoTitleNotifier = ref.watch(todoTitleProvider.notifier);

    final _todoTitleText = ref.watch(todoTitleTextNotifier);
    final _todoTitleTextNotifier = ref.watch(todoTitleTextNotifier.notifier);

    final _selectShowMenuCategory = ref.watch(selectCategoryProvider);
    final _selectShowMenuCategoryNotifier =
        ref.watch(selectCategoryProvider.notifier);

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
                color: selectColor[100],
                padding: const EdgeInsets.all(10),
                // margin: const EdgeInsets.all(5),

                // ReorderableListViewバージョン
                // -------------------------------------------------------
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
                            // color: selectColor[200],
                            color: selectColor[50],
                            child: ListTile(
                              onTap: () {
                                print("Card onTap");
                                showModalBottomSheet<void>(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16)),
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
                                    // _todoModelNotifier.addTodo(
                                    //   TodoModel(
                                    //     1,
                                    //     _todoTitle.text,
                                    //     "",
                                    //     "",
                                    //     false,
                                    //     _selectShowMenuCategory,
                                    //     1,
                                    //     DateTime.now(),
                                    //     DateTime.now(),
                                    //   ),
                                    // );

                                    print("ontap : ${index}");
                                    return TodoMake(index, selectCategory,
                                        _todoModel[index].title);
                                  },
                                );
                              },
                              dense: true,
                              contentPadding: const EdgeInsets.only(left: 5),
                              trailing: Checkbox(
                                onChanged: (val) {
                                  print("Checkbox onChanged");
                                },
                                value: _todoModel[index].isChecked,
                              ),
                              title: Text(
                                _todoModel[index].title,
                                style: const TextStyle(fontSize: 16),
                              ),
                              subtitle: Text("本日 18:00"),
                            ),
                          ),
                        ),
                  ],
                ),
                // -------------------------------------------------------
                // ReorderableListViewバージョン

                // ReorderableListView.builderバージョン
                // -------------------------------------------------------
                // child: ReorderableListView.builder(
                //   itemCount: _todoModel.length,
                //   onReorder: ((oldIndex, newIndex) {
                //     _todoModelNotifier.replaceTodo(oldIndex, newIndex);
                //   }),
                //   itemBuilder: (context, index) {
                //     if (_todoModel.length == 0) {
                //       print("_todoModel.length == 0");
                //       return Center(
                //         child: Text("タスクを追加しましょう"),
                //       );
                //     }
                //     return Dismissible(
                //       key: ValueKey(_todoModel[index]),
                //       background: Container(
                //         color: Colors.red,
                //         child: const Icon(Icons.delete),
                //       ),
                //       onDismissed: (direction) {
                //         _todoModelNotifier.deleteTodo(index);
                //       },
                //       child: Card(
                //         // color: selectColor[200],
                //         color: selectColor[50],
                //         child: ListTile(
                //           onTap: () {
                //             print("Card onTap");
                //             showModalBottomSheet<void>(
                //               shape: const RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.vertical(
                //                     top: Radius.circular(16)),
                //               ),
                //               barrierColor: Colors.black.withAlpha(1),
                //               // backgroundColor: Colors.transparent,
                //               constraints: BoxConstraints(
                //                   maxHeight:
                //                       MediaQuery.of(context).size.height *
                //                           0.95),
                //               isDismissible: true,
                //               isScrollControlled: true,
                //               context: context,
                //               builder: (BuildContext context) {
                //                 return TodoMake();
                //               },
                //             );
                //           },
                //           dense: true,
                //           contentPadding: const EdgeInsets.only(left: 5),
                //           trailing: Checkbox(
                //             onChanged: (val) {
                //               print("Checkbox onChanged");
                //             },
                //             value: _todoModel[index].isChecked,
                //           ),
                //           title: Text(
                //             _todoModel[index].title,
                //             style: const TextStyle(fontSize: 16),
                //           ),
                //           subtitle: Text("本日 18:00"),
                //         ),
                //       ),
                //     );
                //   },
                // ),

                // -------------------------------------------------------
                // ReorderableListView.builderバージョン
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
                return TodoMake("", selectCategory, "");
              },
            ).then((value) {
              print("showDialog Close");
              _todoTitle.text = "";
              _selectShowMenuCategoryNotifier
                  .clear(_selectShowMenuCategory.toString());
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  // Widget _emptyTodo(BuildContext context) {
  //   return ListTile(
  //     title: const Text("＋ タスクを追加", style: TextStyle(fontSize: 16)),
  //     dense: true,
  //     contentPadding: const EdgeInsets.only(left: 5),
  //     onTap: () async {
  //       await showModalBottomSheet<void>(
  //         shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //         ),
  //         barrierColor: Colors.black.withAlpha(1),
  //         backgroundColor: Colors.white,
  //         constraints: BoxConstraints(
  //             maxHeight: MediaQuery.of(context).size.height * 0.95),
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
}
