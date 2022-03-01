import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_matrix/component/todo_list_view_model.dart';

class TodoList extends ConsumerWidget {
  final _index;
  final _isChecked;
  final _title;
  final _subTitle;

  const TodoList(this._index, this._isChecked, this._title, this._subTitle,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _isChecked = ref.watch(isTodoCheckBoxProvider);
    final _isCheckedNotifier = ref.watch(isTodoCheckBoxProvider.notifier);

// return Container(child: ,);

    return ListTile(
      title: Text(_title),
      subtitle: Text(_subTitle),
      trailing: Checkbox(
          value: _isChecked,
          onChanged: ((value) {
            _isCheckedNotifier.check(value!);
          })),
      onTap: () {},
      contentPadding: const EdgeInsets.only(left: 2, right: 2),
    );
  }

  _addTile() {}

  _todoTile() {}
}
