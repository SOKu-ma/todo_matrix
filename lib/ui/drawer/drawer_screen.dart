import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_matrix/common/common.dart';
import 'package:todo_matrix/ui/drawer/drawer_view_model.dart';

class DrawerScreen extends ConsumerWidget {
  const DrawerScreen({Key? key, required this.color}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _color = ref.watch(appColorProvider);
    final _colorNotifier = ref.watch(appColorProvider.notifier);

    final _darkModeSwitch = ref.watch(darkModeSwitchProvider);
    final _darkModeSwitchNotifier = ref.watch(darkModeSwitchProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            _drawerAccount(),
            const SizedBox(height: 40),
            Container(
                margin: const EdgeInsets.only(left: 15, right: 10),
                child: const Text("基本設定")),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text("ダークモード", style: TextStyle(fontSize: 16)),
                trailing: Switch(
                  onChanged: (value) {
                    // ダークモード切替
                    _darkModeSwitchNotifier.change(value);
                    _darkModeSwitch ? ThemeData.dark() : ThemeData.light();
                  },
                  value: _darkModeSwitch,
                ),
              ),
            ),
            _drawerRow("アプリのテーマカラー", const Icon(Icons.color_lens)),
            const SizedBox(height: 40),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 10),
                child: const Text("その他")),
            _drawerRow(
              "アプリのレビューする",
              const Icon(Icons.reviews),
            ),
            _drawerRow("開発者の他のアプリ", const Icon(Icons.apps_rounded)),
            _drawerRow(
              "利用規約",
              const Icon(Icons.apps_rounded),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: const ListTile(
                  leading: Icon(Icons.phone_iphone), title: Text("バージョン情報")),
            )
          ],
        ),
      ),
    );
  }

  // アカウント情報
  Widget _drawerAccount() {
    return ListTile(
      onTap: () {},
      leading: const Icon(
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
