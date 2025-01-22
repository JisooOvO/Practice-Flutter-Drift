import 'package:flutter/material.dart';

class MessengerService {
  static MessengerService? _instance;

  factory MessengerService() {
    _instance ??= MessengerService._();

    return _instance!;
  }

  static MessengerService get instance => MessengerService();

  MessengerService._();

  //---------------------------------------------------------------------------

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  late final currentState = scaffoldMessengerKey.currentState;

  //---------------------------------------------------------------------------

  void removeCurrentSnackBar() {
    currentState?.removeCurrentSnackBar();
  }

  void showSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    removeCurrentSnackBar();
    currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
      ),
    );
  }
}
