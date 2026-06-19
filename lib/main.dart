import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hearwithme/app.dart';
import 'package:hearwithme/core/utils/logger.dart';
import 'package:hearwithme/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait orientation on mobile
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // System UI overlay styling
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0A0A0A),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Initialize dependency injection
  await configureDependencies();

  // Global error handler
  FlutterError.onError = (details) {
    AppLogger.error(
      'Flutter framework error',
      error: details.exception,
      stackTrace: details.stack,
      tag: 'FlutterError',
    );
  };

  AppLogger.info('🎧 HearWithMe starting...', tag: 'App');

  runApp(const HearWithMeApp());
}
