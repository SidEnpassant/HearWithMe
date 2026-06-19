import 'dart:io';

import 'package:flutter/foundation.dart';

/// Platform detection helpers.
abstract final class PlatformInfo {
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;
  static bool get isIOS => !kIsWeb && Platform.isIOS;
  static bool get isMobile => isAndroid || isIOS;
  static bool get isDesktop =>
      !kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux);
  static bool get isWeb => kIsWeb;

  /// Whether the platform supports Wi-Fi Direct P2P.
  static bool get supportsWifiDirect => isAndroid;

  /// Whether the platform supports MultipeerConnectivity.
  static bool get supportsMultipeer => isIOS;

  /// Whether any P2P transport is available.
  static bool get supportsP2P => supportsWifiDirect || supportsMultipeer;

  /// Whether the platform supports BLE.
  static bool get supportsBle => isMobile;

  /// Whether biometric authentication is supported.
  static bool get supportsBiometrics => isMobile;
}
