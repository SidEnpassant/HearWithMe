import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

/// Structured logging utility.
///
/// In debug mode, logs to console with tag prefix.
/// In release mode, silently drops logs (or could be
/// routed to a crash reporting service).
abstract final class AppLogger {
  static void debug(String message, {String? tag}) {
    if (kDebugMode) {
      dev.log(message, name: tag ?? 'HearWithMe');
    }
  }

  static void info(String message, {String? tag}) {
    if (kDebugMode) {
      dev.log('ℹ️ $message', name: tag ?? 'HearWithMe');
    }
  }

  static void warning(String message, {String? tag}) {
    if (kDebugMode) {
      dev.log('⚠️ $message', name: tag ?? 'HearWithMe');
    }
  }

  static void error(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      dev.log(
        '❌ $message',
        name: tag ?? 'HearWithMe',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
