import 'package:flutter/material.dart';

class NavigatorService {
  static NavigatorService? _instance;

  factory NavigatorService() {
    _instance ??= NavigatorService._();

    return _instance!;
  }

  static NavigatorService get instance => NavigatorService();

  NavigatorService._();

  //---------------------------------------------------------------------------

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  late final currentState = navigatorKey.currentState;

  //---------------------------------------------------------------------------

  Future<void> push(Widget page) async {
    await currentState?.push(
      MaterialPageRoute(
        builder: (context) {
          return page;
        },
      ),
    );
  }

  Future<void> pop() async {
    currentState?.pop();
  }
}
