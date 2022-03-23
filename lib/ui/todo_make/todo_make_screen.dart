import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_matrix/model/select_category_model.dart';
import 'package:todo_matrix/model/todo_model.dart';
import 'package:todo_matrix/ui/todo_make/todo_make_view_model.dart';

final _formKey = GlobalKey<FormState>();

class TodoMake extends ConsumerWidget {
  final index;
  final title;
  final selectCategory;
  final notificateionDate;

  const TodoMake(
      this.index, this.selectCategory, this.notificateionDate, this.title,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final _selected = ref.watch(selectCategoryProvider);
    // final _selectedNotifier = ref.watch(selectCategoryProvider.notifier);

    final _todoModel = ref.watch(todoModelProvider);
    final _todoModelNotifier = ref.watch(todoModelProvider.notifier);

    final _todoTitleText = ref.watch(todoTitleTextNotifier);
    final _todoTitleTextNotifier = ref.watch(todoTitleTextNotifier.notifier);

    // TextEditingController _todoTitleTextEditController =
    //     TextEditingController(text: _todoTitleText);
    final _todoTitleTextEditingController =
        ref.watch(todoTitleTextEditingProvider);
    final _todoTitleTextEditingControllerNotifier =
        ref.watch(todoTitleTextEditingProvider.notifier);

    final _selectCategory = ref.watch(selectCategoryProvider);
    final _selectCategoryNotifier = ref.watch(selectCategoryProvider.notifier);

    final _notificationDate = ref.watch(notificationDate);
    final _notificationDateNotifier = ref.watch(notificationDate.notifier);

    return Column(
      children: [
        const SizedBox(height: 30),
        Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
          child: TextFormField(
            autofocus: true,
            decoration: const InputDecoration(hintText: "新しいタスク"),
            controller: _todoTitleTextEditingController,
            key: _formKey,
            validator: (value) {
              if (value == "") {
                // return 'タスクを入力してください';
                Navigator.of(context, rootNavigator: true).pop(context);
              }
              return null;
            },
            onChanged: (value) {
              print("onChangeイベント:" + value);
            },
            onSaved: (value) {
              print("onSaveイベント:" + value!);
            },
            onFieldSubmitted: (value) {
              print("onFieldSubmittedイベント:" + value);
            },
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 25),
        ),

        // 重要度・緊急度を選択するようのPopUpMenu
        Row(
          children: [
            Expanded(
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 25),
                leading: const Icon(Icons.check_box_outlined),
                title: Text(selectCategory.toString().isEmpty
                    ? _selectCategory
                    : selectCategory),
                onTap: () {
                  showMenu(
                    context: context,
                    position: RelativeRect.fill,
                    items: [
                      PopupMenuItem(
                        child: const Text("第１領域 : 緊急かつ重要",
                            style: TextStyle(fontSize: 12)),
                        onTap: () {
                          _selectCategoryNotifier
                              .select(Category.importantUrgent);
                        },
                      ),
                      PopupMenuItem(
                        child: const Text("第２領域 : 緊急でないが重要",
                            style: TextStyle(fontSize: 12)),
                        onTap: () {
                          _selectCategoryNotifier
                              .select(Category.importantUnUrgent);
                        },
                      ),
                      PopupMenuItem(
                        child: const Text("第３領域 : 緊急だが重要でない",
                            style: TextStyle(fontSize: 12)),
                        onTap: () {
                          _selectCategoryNotifier
                              .select(Category.unImportantUrgent);
                        },
                      ),
                      PopupMenuItem(
                        child: const Text("第４領域 : 緊急でなく重要でもない",
                            style: TextStyle(fontSize: 12)),
                        onTap: () {
                          _selectCategoryNotifier
                              .select(Category.unImportantUnUrgent);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 25),
                leading: const Icon(Icons.timer),
                title: Text(_notificationDate),
                onTap: () {
                  // Todo編集
                  showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) => Container(
                      height: 216,
                      padding: const EdgeInsets.only(top: 6.0),
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      color: CupertinoColors.inactiveGray.resolveFrom(context),
                      child: SafeArea(
                        top: false,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.dateAndTime,
                          onDateTimeChanged: (value) {
                            // ref.read(notificationDate.notifier).edit(value);
                            _notificationDateNotifier.edit(value);
                          },
                          initialDateTime: DateTime.now(),
                          // backgroundColor:
                          //     CupertinoColors.inactiveGray.resolveFrom(context),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: ElevatedButton(
            onPressed: () {
              // テキストnullチェック
              if (_todoTitleTextEditingController.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text(
                      "タスクを入力してください",
                      style: TextStyle(fontSize: 16),
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
              }

              // カテゴリー未選択時
              if (_selectCategory == defImpUrgText) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text(
                      "カテゴリーを選択してください",
                      style: TextStyle(fontSize: 16),
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
              }

              // TODO 暫定対応
              countID++;

              // Todoモデルに保存
              TodoModel _todo = TodoModel(
                  countID,
                  _todoTitleTextEditingController.text,
                  _notificationDate,
                  DateFormat('yyyy/MM/dd').format(DateTime.now()),
                  false,
                  // _selected);
                  _selectCategory,
                  1,
                  DateTime.now(),
                  DateTime.now());
              _todoModelNotifier.addTodo(_todo);
              _selectCategoryNotifier.clear();
              _notificationDateNotifier.clear();
              Navigator.of(context, rootNavigator: true).pop(context);
            },
            child: const Text("保存", style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }
}
