part of 'pixels_bloc.dart';

abstract class PixelsEvent {}

class PixelsEventListen extends PixelsEvent {}

class PixelsHistoryEventListen extends PixelsEvent {}

class PixelsEventAdd extends PixelsEvent {
  final Offset offset;
  final Color color;

  PixelsEventAdd(this.offset, this.color);
}
