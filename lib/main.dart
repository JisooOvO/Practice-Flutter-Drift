import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:practice_flutter_drift/components/future_list_view.dart';
import 'package:practice_flutter_drift/components/text_editor.dart';
import 'package:practice_flutter_drift/services/database_service.dart';
import 'package:practice_flutter_drift/services/messenger_service.dart';
import 'package:practice_flutter_drift/services/navigator_service.dart';

final naviService = NavigatorService.instance;
final msgService = MessengerService.instance;
final dbService = DatabaseService.instance;

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      dbService.updateStream();
      runApp(const MainApp());
    },
    (error, stackTrace) {
      log(error.toString());
      debugPrintStack(stackTrace: stackTrace);
    },
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: naviService.navigatorKey,
      scaffoldMessengerKey: msgService.scaffoldMessengerKey,
      home: Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 32.0,
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Todo App',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextEditor(
                  onSubmit: (text) {
                    dbService.addTodo(text);
                  },
                ),
                Expanded(
                  child: FutureListView(stream: dbService.stream),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
