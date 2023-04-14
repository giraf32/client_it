import 'package:client_it/app/ui/main_app_builder.dart';
import 'package:client_it/app/ui/main_app_runner.dart';
import 'package:flutter/material.dart';


void main() {
 WidgetsFlutterBinding.ensureInitialized();
 const env = String.fromEnvironment('env',defaultValue: 'prod');
 final runner = MainAppRunner(env);
 final builder = MainAppBuilder();
 //const String app = 'prod';

 runner.run(builder);
}

