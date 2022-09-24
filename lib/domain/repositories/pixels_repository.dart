import 'package:firebase_database/firebase_database.dart';

import '../entities/pixel.dart';

abstract class PixelsRepository {
  Stream<Pixel> listenPixels();
  Stream<Pixel> listenHistory();
  Future<Pixel> createPixel(Pixel pixel);
}
