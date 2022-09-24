import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: 'dotenv');
  await initFirebase(Environment.prod);
  configureDependencies(Environment.prod);
  runApp(EasyLocalization(
    supportedLocales: const [
      Locale('en'),
      Locale('fr'),
    ],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    child: const App(),
  ));
}

Future<void> initFirebase(String environment) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
