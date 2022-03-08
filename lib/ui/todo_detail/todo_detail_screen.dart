import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_matrix/model/TodoModel.dart';
import 'package:todo_matrix/ui/todo_make/todo_make_screen.dart';

class TodoDetail extends ConsumerWidget {
  final selectCategory;

  TodoDetail(this.selectCategory, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _todoModel = ref.watch(todoModelProvider);
    final _todoModelNotifier = ref.watch(todoModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            Navigator.of(context).pop(context);
          },
        ),
        title: Text(selectCategory),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Container(
            //   color: Colors.green,
            //   child: Row(
            //     children: [
            //       const CloseButton(
            //         color: Colors.white,
            //       ),
            //       SizedBox(width: MediaQuery.of(context).size.width / 5),
            //       Text(
            //         selectCategory,
            //         style: const TextStyle(fontSize: 20, color: Colors.white),
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    for (final todo in _todoModel)
                      if (todo.category.toString() ==
                          "Category." + selectCategory.toString())
                        Card(
                          child: CheckboxListTile(
                            dense: true,
                            contentPadding: const EdgeInsets.only(left: 5),
                            value: todo.isChecked,
                            title: Text(
                              todo.title,
                              style: const TextStyle(fontSize: 16),
                            ),
                            onChanged: (val) {},
                          ),
                        ),
                    _emptyTodo(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
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
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _emptyTodo(BuildContext context) {
    return ListTile(
      title: const Text("＋ タスクを追加", style: TextStyle(fontSize: 16)),
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
}
