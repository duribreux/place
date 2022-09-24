import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<GetIt> configureInjector(
  GetIt getIt, {
  String? env,
}) =>
    $initGetIt(getIt, environment: env);
