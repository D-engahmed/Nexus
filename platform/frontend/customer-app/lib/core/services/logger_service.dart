import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  // Configure the logger once
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Show 2 lines of call stack
      errorMethodCount: 8, // Show 8 lines on error
      lineLength: 120, // Width of output
      colors: true, // Colorful output
      printEmojis: true, // Emojis for visual separation
      printTime: true, // Add timestamps
    ),
    // In production, reduce noise by filtering out debug logs
    level: kReleaseMode ? Level.info : Level.debug,
  );

  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.d(message, error: error, stackTrace: stackTrace);

  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.i(message, error: error, stackTrace: stackTrace);

  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.w(message, error: error, stackTrace: stackTrace);

  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}
