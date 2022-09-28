import 'package:async/async.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/pixel.dart';
import '../../domain/repositories/pixels_repository.dart';
import '../models/pixel_model.dart';

@Injectable(as: PixelsRepository)
class FirebasePixelsRepository extends PixelsRepository {
  final FirebaseDatabase _database;

  FirebasePixelsRepository(this._database);

  @override
  Future<Pixel> createPixel(Pixel pixel) {
    final hash = pixel.offset.hashCode;

    return Future.wait([
      _database.ref('pixels/$hash').set(PixelModel.from(pixel).toJson()),
      _database.ref('history').push().set(PixelModel.from(pixel).toJson()),
    ]).then((value) => Future.value(pixel));
  }

  @override
  Stream<PixelModel> listenPixels() => StreamGroup.merge([
        _database.ref('pixels').orderByChild('createdAt').onChildAdded.map(
            (event) => PixelModel.fromJson(
                event.snapshot.value as Map<String, dynamic>)),
        _database.ref('pixels').onChildChanged.map((event) =>
            PixelModel.fromJson(event.snapshot.value as Map<String, dynamic>)),
      ]);

  @override
  Stream<PixelModel> listenHistory() =>
      _database.ref('history').limitToLast(50).onChildAdded.map((event) =>
          PixelModel.fromJson(event.snapshot.value as Map<String, dynamic>));
}
