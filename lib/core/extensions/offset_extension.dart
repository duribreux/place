import 'dart:ui';

extension OffsetExtension on Offset {
  Offset round() => Offset(
        (dx - dx.remainder(10)).truncateToDouble(),
        (dy - dy.remainder(10)).truncateToDouble(),
      );
}
