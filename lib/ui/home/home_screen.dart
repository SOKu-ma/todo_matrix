import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_matrix/common/common.dart';
import 'package:todo_matrix/ui/drawer/drawer_screen.dart';
import 'package:todo_matrix/ui/home_divide/home_divide_screen.dart';
import 'package:todo_matrix/ui/todo_make/todo_make_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _color = ref.watch(appColorProvider);
    final _colorNotifier = ref.watch(appColorProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
          child: DrawerScreen(
        color: _color,
      )),
      body: const SafeArea(child: HomeDivide()),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
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
      ),
    );
  }
}
