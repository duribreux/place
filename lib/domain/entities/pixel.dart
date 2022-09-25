import 'dart:ui';

import 'package:equatable/equatable.dart';

class Pixel extends Equatable {
  final Offset offset;
  final Color color;
  final String uuid;
  final DateTime createdAt;

  const Pixel({
    required this.offset,
    required this.color,
    required this.uuid,
    required this.createdAt,
  });

  @override
  List<Object> get props => [offset, color, uuid];
}
