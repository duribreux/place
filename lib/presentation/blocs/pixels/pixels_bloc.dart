import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../core/extensions/offset_extension.dart';
import '../../../data/models/pixel_model.dart';
import '../../../domain/entities/pixel.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/pixels_repository.dart';

part 'pixels_event.dart';
part 'pixels_state.dart';

@injectable
class PixelsBloc extends Bloc<PixelsEvent, PixelsState> {
  final List<Pixel> pixels = [];
  final List<Pixel> history = [];

  final PixelsRepository _pixelsRepository;
  final AuthRepository _authRepository;

  late StreamSubscription<Pixel> _pixelsSubscription;
  late StreamSubscription<Pixel> _pixelsHistorySubscription;

  StreamController pixelsController = StreamController<List<Pixel>>.broadcast();
  Stream<List<Pixel>> get pixelsStream =>
      pixelsController.stream as Stream<List<Pixel>>;
  Sink get pixelsSink => pixelsController.sink;

  StreamController pixelsHistoryController =
      StreamController<List<Pixel>>.broadcast();
  Stream<List<Pixel>> get pixelsHistoryStream =>
      pixelsHistoryController.stream as Stream<List<Pixel>>;
  Sink get pixelsHistorySink => pixelsHistoryController.sink;

  PixelsBloc(
    this._pixelsRepository,
    this._authRepository,
  ) : super(PixelsInitial()) {
    on<PixelsEventListen>((event, emit) {
      _pixelsSubscription = _pixelsRepository.listenPixels().listen(
        (data) {
          pixels.add(data);
          pixelsSink.add(pixels);
        },
        onError: (error) {
          log('Stream: $error');
        },
        cancelOnError: false,
      );
    });

    on<PixelsEventAdd>((event, emit) {
      if (!_authRepository.isSignedIn) {
        emit(PixelsUnauthorized());
      } else {
        _pixelsRepository.createPixel(PixelModel(
          offset: event.offset.round(),
          color: event.color,
          uuid: _authRepository.uid,
        ));
      }
    });

    on<PixelsHistoryEventListen>((event, emit) {
      _pixelsHistorySubscription = _pixelsRepository.listenHistory().listen(
        (data) {
          history.add(data);
          pixelsHistorySink.add(history.reversed.toList());
        },
        onError: (error) {
          log('Stream: $error');
        },
        cancelOnError: false,
      );
    });
  }

  @override
  Future<void> close() {
    _pixelsSubscription.cancel();
    pixelsController.close();
    _pixelsHistorySubscription.cancel();
    pixelsHistoryController.close();
    return super.close();
  }
}
