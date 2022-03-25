import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final impUrgColorProvider = StateProvider((ref) => Colors.red);
final impUnUrgColorProvider = StateProvider((ref) => Colors.orange);
final unImpUrgColorProvider = StateProvider((ref) => Colors.green);
final unImpUnUrgColorProvider = StateProvider((ref) => Colors.blue);

final darkMode = StateProvider((ref) => Colors.red);

final verticalTextProvider = StateProvider((ref) => '重要');
final horizonalTextProvider = StateProvider((ref) => '緊急');
final denaialTextProvider = StateProvider((ref) => 'でない');
