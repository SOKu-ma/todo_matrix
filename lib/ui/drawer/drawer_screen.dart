import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_matrix/common/common.dart';

class DrawerScreen extends ConsumerWidget {
  const DrawerScreen({Key? key, required this.color}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _color = ref.watch(appColorProvider);
    final _colorNotifier = ref.watch(appColorProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            _drawerAccount(),
            const SizedBox(height: 40),
            Container(
                margin: const EdgeInsets.only(left: 15, right: 10),
                child: const Text("基本設定")),
            _drawerRow(
                "ダークモード",
                const Icon(
                  Icons.dark_mode,
                  // color: Colors.green,
                )),
            _drawerRow(
                "アプリカラー",
                const Icon(
                  Icons.color_lens,
                  // color: Colors.green,
                )),
            const SizedBox(height: 40),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 10),
                child: const Text("その他")),
            _drawerRow(
              "アプリのレビューする",
              const Icon(
                Icons.reviews,
                // color: Colors.green,
              ),
            ),
            _drawerRow(
                "開発者の他のアプリ",
                const Icon(
                  Icons.apps_rounded,
                  // color: Colors.green,
                )),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: const ListTile(
                leading: Icon(
                  Icons.phone_iphone,
                ),
                title: Text("バージョン情報"),
              ),
            )
          ],
        ),
      ),
    );
  }

  // アカウント情報
  Widget _drawerAccount() {
    return GestureDetector(
      child: Container(
        child: const ListTile(
          leading: Icon(
            Icons.account_circle,
          ),
          title: Text(
            "ユーザー（ゲスト）",
            style: TextStyle(fontSize: 16),
          ),
          subtitle: Text(
            "aaa@test.jp",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      onTap: () {},
    );
  }

  // アカウント情報以外
  Widget _drawerRow(String title, Icon icon) {
    return Container(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        onTap: () {
          switch (title) {
            case "アプリカラー":
              // ColorPicker
              print("アプリカラー 押下");
              break;
            default:
          }
        },
      ),
    );
  }
}
