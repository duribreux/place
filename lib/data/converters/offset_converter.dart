import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class OffsetConverter implements JsonConverter<Offset, Map<String, dynamic>> {
  const OffsetConverter();

  @override
  Offset fromJson(Map<String, dynamic> json) => Offset(json['x']!, json['y']!);

  @override
  Map<String, dynamic> toJson(Offset offset) => {
        'x': offset.dx,
        'y': offset.dy,
      };
}
