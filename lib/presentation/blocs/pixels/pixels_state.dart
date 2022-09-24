part of 'pixels_bloc.dart';

abstract class PixelsState extends Equatable {
  @override
  List<Object> get props => [];
}

class PixelsInitial extends PixelsState {}

class PixelsLoading extends PixelsState {}

class PixelsLoaded extends PixelsState {
  final List<Pixel> pixels;

  PixelsLoaded(this.pixels);

  @override
  List<Object> get props => [pixels];
}

class PixelsUnauthorized extends PixelsState {}
