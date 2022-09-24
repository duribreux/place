import 'dart:ui';

extension OffsetExtension on Offset {
  Offset round() => Offset(
        (dx - dx.remainder(10)).truncateToDouble() + 5,
        (dy - dy.remainder(10)).truncateToDouble() + 5,
      );
}
