import 'dart:ui';

import 'package:equatable/equatable.dart';

class Pixel extends Equatable {
  final Offset offset;
  final Color color;
  final String uuid;

  const Pixel({
    required this.offset,
    required this.color,
    required this.uuid,
  });

  @override
  List<Object> get props => [offset, color, uuid];
}
