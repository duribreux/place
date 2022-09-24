import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class ColorConverter implements JsonConverter<Color, Map<String, dynamic>> {
  const ColorConverter();

  @override
  Color fromJson(Map<String, dynamic> json) => Color.fromRGBO(
        json['r']!,
        json['g']!,
        json['b']!,
        1,
      );

  @override
  Map<String, dynamic> toJson(Color color) => {
        'r': color.red,
        'g': color.green,
        'b': color.blue,
      };
}
