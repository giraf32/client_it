import 'package:client_it/app/domain/app_config.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AppConfig)
@prod
class ProdAppConfig implements AppConfig {
  @override
  String get baseUri => 'http://188.120.248.170';
  //"http://188.120.225.54";
  //'http://188.120.248.170';
  // String get baseUri => '127.0.0.1';

  @override
  String get host => Environment.prod;
}

@Singleton(as: AppConfig)
@dev
class DevAppConfig implements AppConfig {
  @override
  String get baseUri => 'localhost';

  @override
  String get host => Environment.dev;
}

@Singleton(as: AppConfig)
@test
class TestAppConfig implements AppConfig {
  @override
  String get baseUri => '_';

  @override
  String get host => Environment.test;
}
