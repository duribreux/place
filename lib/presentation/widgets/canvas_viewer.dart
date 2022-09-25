import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/entities/pixel.dart';
import '../blocs/pixels/pixels_bloc.dart';
import 'my_painter.dart';

class CanvasViewer extends StatelessWidget {
  const CanvasViewer({
    Key? key,
    required this.pixelsBloc,
    required this.color,
    required this.pixels,
  }) : super(key: key);

  final PixelsBloc pixelsBloc;
  final List<Pixel> pixels;
  final Color color;

  @override
  Widget build(BuildContext context) => InteractiveViewer(
        constrained: false,
        minScale: 0.2,
        maxScale: 15,
        child: SizedBox(
          width: 1920,
          height: 1080,
          child: Listener(
            onPointerDown: (event) {
              if (RawKeyboard.instance.keysPressed.isEmpty) {
                pixelsBloc.add(PixelsEventAdd(
                  event.localPosition,
                  color,
                ));
              }
            },
            child: CustomPaint(
              size: const Size(1920, 1080),
              painter: MyPainter(
                pixels: pixels,
              ),
            ),
          ),
        ),
      );
}
