import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// アプリカラーテーマ
final appColorProvider = StateProvider((ref) => Colors.green);

const strHigh = "（高）";
const strLow = "（低）";
