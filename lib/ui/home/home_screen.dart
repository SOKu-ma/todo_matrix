import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_matrix/common/common.dart';
import 'package:todo_matrix/ui/drawer/drawer_screen.dart';
import 'package:todo_matrix/ui/home_divide/home_divide_screen.dart';
import 'package:todo_matrix/ui/todo_make/todo_make_screen.dart';
import 'package:todo_matrix/ui/todo_make/todo_make_view_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _color = ref.watch(appColorProvider);
    final _colorNotifier = ref.watch(appColorProvider.notifier);

    final _todoTitleText = ref.watch(todoTitleTextProvider);
    final _todoTitleTextNotifier = ref.watch(todoTitleTextProvider.notifier);

    final _selectShowMenuCategory = ref.watch(selectCategoryProvider);
    final _selectShowMenuCategoryNotifier =
        ref.watch(selectCategoryProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
          child: DrawerScreen(
        color: _color,
      )),
      body: const SafeArea(child: HomeDivide()),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 70),
        child: FloatingActionButton(
          // backgroundColor: _color,
          foregroundColor: Colors.white,
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
                return TodoMake("", "", "", "");
              },
            ).then((value) {
              print("showDialog Close");
              _todoTitleTextNotifier.clear();
              // _todoTitleNotifier.clear();
              _selectShowMenuCategoryNotifier.clear();
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
