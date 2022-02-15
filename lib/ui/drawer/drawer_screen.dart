import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key, required this.color}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            _drawerAccount(),
            const SizedBox(height: 40),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 10),
                child: const Text("基本設定")),
            _drawerRow(
                "アプリカラー", const Icon(Icons.color_lens, color: Colors.green)),
            const SizedBox(height: 40),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 10),
                child: const Text("その他")),
            _drawerRow(
                "レビューする", const Icon(Icons.reviews, color: Colors.green)),
            _drawerRow("開発者の他のアプリ",
                const Icon(Icons.apps_rounded, color: Colors.green)),
            _drawerRow("アプリのバージョン",
                const Icon(Icons.phone_iphone_outlined, color: Colors.green)),
          ],
        ),
      ),
    );
  }

  // アカウント情報
  Widget _drawerAccount() {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: const ListTile(
          leading: Icon(
            Icons.account_circle,
            color: Colors.green,
          ),
          title: Text("ユーザー（ゲスト）"),
          subtitle: Text("aaa@test.jp"),
        ),
      ),
      onTap: () {},
    );
  }

  // アカウント情報以外
  Widget _drawerRow(String title, Icon icon) {
    return Container(
      // margin: const EdgeInsets.only(left: 30, right: 30),
      // decoration: const BoxDecoration(
      // border: Border(
      // bottom: BorderSide(color: Colors.grey),
      // ),
      // ),
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: ListTile(
        leading: icon,
        title: Text(title),
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
