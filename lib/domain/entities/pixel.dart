import 'dart:ui';

import 'package:equatable/equatable.dart';

class Pixel extends Equatable {
  final Offset offset;
  final Color color;

  const Pixel({
    required this.offset,
    required this.color,
  });

  @override
  List<Object> get props => [offset, color];
}
