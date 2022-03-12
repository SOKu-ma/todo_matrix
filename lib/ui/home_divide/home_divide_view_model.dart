import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final impUrgColor = StateProvider((ref) => Colors.red);
final impUnUrgColor = StateProvider((ref) => Colors.orange);
final unImpUrgColor = StateProvider((ref) => Colors.green);
final unImpUnUrgColor = StateProvider((ref) => Colors.blue);
