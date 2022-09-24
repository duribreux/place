import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/pixel.dart';
import '../converters/color_converter.dart';
import '../converters/offset_converter.dart';

part 'pixel_model.g.dart';

@JsonSerializable(explicitToJson: true)
@OffsetConverter()
@ColorConverter()
class PixelModel extends Pixel {
  PixelModel({
    required super.offset,
    required super.color,
  });

  factory PixelModel.from(Pixel other) => PixelModel(
        offset: other.offset,
        color: other.color,
      );

  // coverage:ignore-start
  factory PixelModel.fromJson(Map<String, dynamic> json) =>
      _$PixelModelFromJson(json);

  Map<String, dynamic> toJson() => _$PixelModelToJson(this);
  // coverage:ignore-end
}
