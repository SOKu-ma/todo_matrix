import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_matrix/common/common.dart';
import 'package:todo_matrix/ui/home_grid/home_grid_view_model.dart';

class HomeGrid extends ConsumerWidget {
  const HomeGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _color = ref.watch(appColorProvider);
    final _colorNotifier = ref.watch(appColorProvider.notifier);

    final _verticalText = ref.watch(verticalTextProvider);
    final _horizonalText = ref.watch(horizonalTextProvider);

    return Container(
      child: Row(
        children: [
          RotatedBox(
            quarterTurns: 1,
            child: RichText(
              text: TextSpan(
                text: _horizonalText + ('（高）'),
                style: DefaultTextStyle.of(context).style,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: _verticalText + ('（高）'),
                        style: DefaultTextStyle.of(context).style,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      childAspectRatio: 0.6,
                      children: [
                        for (int i = 0; i < 4; i++) HomeGridTile(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: _verticalText + ('（低）'),
                        style: DefaultTextStyle.of(context).style,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          RotatedBox(
            quarterTurns: 1,
            child: RichText(
              text: TextSpan(
                text: _horizonalText + ('（低）'),
                style: DefaultTextStyle.of(context).style,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeGridTile extends ConsumerWidget {
  const HomeGridTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _color = ref.watch(appColorProvider);
    final _colorNotifier = ref.watch(appColorProvider.notifier);

    final _isChecked = ref.watch(isCheckedProvider);
    final _isCheckedNotifier = ref.watch(isCheckedProvider.notifier);

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: _color),
      ),
      child: GridTile(
        child: Center(
          child: ListView(children: [
            CheckboxListTile(
              title: const Text("TODO", style: TextStyle(fontSize: 10)),
              value: _isChecked,
              onChanged: (val) {
                _isCheckedNotifier.checked(val!);
              },
            ),
          ]),
        ),
      ),
    );
  }
}
