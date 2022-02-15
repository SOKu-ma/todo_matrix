import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_matrix/common/common.dart';
import 'package:todo_matrix/ui/drawer/drawer_screen.dart';
import 'package:todo_matrix/ui/home_divide/home_divide_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _color = ref.watch(appColorProvider);
    final _colorNotifier = ref.watch(appColorProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      drawer: Drawer(
          child: DrawerScreen(
        color: _color,
      )),
      body: SafeArea(
          // child: HomeGrid(),
          child: HomeDivide()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
