import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/pixel.dart';
import '../converters/color_converter.dart';
import '../converters/date_time_converter.dart';
import '../converters/offset_converter.dart';

part 'pixel_model.g.dart';

@JsonSerializable(explicitToJson: true)
@OffsetConverter()
@ColorConverter()
@DateTimeConverter()
class PixelModel extends Pixel {
  const PixelModel({
    required super.offset,
    required super.color,
    required super.uuid,
    required super.createdAt,
  });

  factory PixelModel.from(Pixel other) => PixelModel(
        offset: other.offset,
        color: other.color,
        uuid: other.uuid,
        createdAt: other.createdAt,
      );

  // coverage:ignore-start
  factory PixelModel.fromJson(Map<String, dynamic> json) =>
      _$PixelModelFromJson(json);

  Map<String, dynamic> toJson() => _$PixelModelToJson(this);
  // coverage:ignore-end
}
