import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_matrix/model/select_category_model.dart';
import 'package:todo_matrix/model/todo_model.dart';
import 'package:todo_matrix/ui/todo_make/todo_make_view_model.dart';

final _formKey = GlobalKey<FormState>();

class TodoMake extends ConsumerWidget {
  final index;
  final title;
  final selectCategory;
  final limitDate;

  const TodoMake(this.index, this.selectCategory, this.limitDate, this.title,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _todoModelNotifier = ref.watch(todoModelProvider.notifier);

    final _todoTitleText = ref.watch(todoTitleTextProvider);
    final _todoTitleTextNotifier = ref.watch(todoTitleTextProvider.notifier);

    final _todoTitleTextEditingController =
        ref.watch(todoTitleTextEditingProvider);

    final _selectCategory = ref.watch(selectCategoryProvider);
    final _selectCategoryNotifier = ref.watch(selectCategoryProvider.notifier);

    final _notificationStringDate = ref.watch(notificationStringDateProvider);
    final _notificationStringDateNotifier =
        ref.watch(notificationStringDateProvider.notifier);

    final _notificationDate = ref.watch(notificationDateProvider);
    final _notificationDateNotifier =
        ref.watch(notificationDateProvider.notifier);

    final _todoOrderProvider = ref.watch(todoOrderProvider);
    final _todoOrderProviderNotifier = ref.watch(todoOrderProvider.notifier);

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
                title: Text(_notificationStringDate),
                onTap: () {
                  _notificationStringDateNotifier.edit(
                      _notificationStringDate.isEmpty
                          ? DateTime.now()
                          : _notificationDate);
                  // 通知設定
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
                          onDateTimeChanged: (dateTime) {
                            _notificationDateNotifier
                                .update((state) => dateTime);
                            _notificationStringDateNotifier.edit(dateTime);
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

              if (index.toString().isEmpty) {
                // Todoタスクの新規追加
                TodoModel _todo = TodoModel(
                    _todoTitleTextEditingController.text,
                    _notificationStringDate,
                    false,
                    _selectCategory,
                    _todoOrderProvider,
                    DateTime.now(),
                    DateTime.now());
                _todoModelNotifier.addTodo(_todo);
                _todoOrderProviderNotifier.update((state) => state + 1);
              } else {
                // Todoモデルの値を更新
                _todoModelNotifier.editTodo(
                    index,
                    _todoTitleTextEditingController.text,
                    _selectCategory,
                    _notificationStringDate);
              }
              _todoTitleTextNotifier.clear();
              _selectCategoryNotifier.clear();
              _notificationStringDateNotifier.clear();
              Navigator.of(context, rootNavigator: true).pop(context);
            },
            child: const Text("保存", style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }
}
