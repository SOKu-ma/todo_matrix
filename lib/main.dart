import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_matrix/common/common.dart';
import 'package:todo_matrix/ui/home/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _color = ref.watch(appColorProvider);
    final _colorNotifier = ref.watch(appColorProvider.notifier);

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: _color,
      ),
      darkTheme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
