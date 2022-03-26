import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDetail extends ConsumerWidget {
  const UserDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Text("ユーザ詳細画面"),
          ),
          Center(
            child: Text("ユーザ詳細画面"),
          ),
        ],
      ),
    );
  }
}
