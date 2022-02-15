import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_matrix/ui/home_grid/home_grid_view_model.dart';

const strHigh = "（高）";
const strLow = "（低）";

class HomeDivide extends ConsumerWidget {
  const HomeDivide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _verticalText = ref.watch(verticalText);
    final _horizonalText = ref.watch(horizonalText);

    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        children: [
          RotatedBox(
            quarterTurns: 1,
            child: RichText(
              text: TextSpan(
                text: _horizonalText + strHigh,
                style: DefaultTextStyle.of(context).style,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: _verticalText + strHigh,
                      style: DefaultTextStyle.of(context).style,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                            width: 50,
                            height: 100,
                            color: Colors.red,
                            child: Text("aaa")),
                      ),
                      const VerticalDivider(
                          color: Colors.grey,
                          indent: 20,
                          // endIndent: 50,
                          thickness: 3),
                      Expanded(
                        child: Container(
                            color: Colors.blue,
                            width: 50,
                            height: 100,
                            child: Text("bbb")),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 3,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                            width: 50,
                            height: 100,
                            color: Colors.red,
                            child: Text("aaa")),
                      ),
                      const VerticalDivider(
                          color: Colors.grey,
                          // indent: 50,
                          endIndent: 20,
                          thickness: 3),
                      Expanded(
                        child: Container(
                            color: Colors.blue,
                            width: 50,
                            height: 100,
                            child: Text("bbb")),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: _verticalText + strLow,
                      style: DefaultTextStyle.of(context).style,
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
                text: _horizonalText + strLow,
                style: DefaultTextStyle.of(context).style,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
