import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

import '../../firebase_options.dart';

@module
abstract class FirebaseModule {
  @singleton
  FirebaseAuth provideFirebaseAuth() => FirebaseAuth.instance;

  @prod
  @preResolve
  @singleton
  Future<FirebaseDatabase> provideFirebaseProdDatabase() async {
    final app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    return FirebaseDatabase.instanceFor(
      app: app,
      databaseURL: dotenv.env['FIREBASE_DATABASE_URL'],
    );
  }
}
