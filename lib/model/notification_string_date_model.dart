import 'package:flutter_riverpod/flutter_riverpod.dart';

const NotifiDefDate = "通知なし";
const OnTheDay = "本日";
const Tommorow = "明日";

// 通知設定用クラス
class NoticicationStringDate extends StateNotifier<String> {
  NoticicationStringDate(String state) : super(state);

  // 時・分を取得
  void edit(DateTime dateTime) {
    final _checkDayAndYear = checkDayAndYear(dateTime);

    state = _checkDayAndYear +
        ' ' +
        dateTime.hour.toString().padLeft(2, '0') +
        ':' +
        dateTime.minute.toString().padLeft(2, '0');
  }

  // 通知ラベルから時・分を取得
  void editStringDate(String dateTime) {
    state = dateTime;
  }

  // テキストをクリア
  void clear() {
    state = NotifiDefDate;
  }

  // 日付・年を判定
  checkDayAndYear(DateTime dateTime) {
    if (dateTime.year > DateTime.now().year) {
      return "";
    } else if (dateTime.day == DateTime.now().day) {
      // 当日
      return OnTheDay;
    } else if (dateTime.day == DateTime.now().day + 1) {
      // 明日
      return Tommorow;
    } else {
      return dateTime.month.toString() + '/' + dateTime.day.toString();
    }
  }
}
