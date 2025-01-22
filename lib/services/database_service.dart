import 'dart:async';

import 'package:drift/drift.dart';
import 'package:practice_flutter_drift/database/database.dart';
import 'package:practice_flutter_drift/main.dart';

class DatabaseService {
  static DatabaseService? _instance;

  factory DatabaseService() {
    _instance ??= DatabaseService._();

    return _instance!;
  }

  static DatabaseService get instance => DatabaseService();

  DatabaseService._();

  //---------------------------------------------------------------------------

  final db = AppDatabase();

  final StreamController<List> _stream = StreamController.broadcast();
  Stream<List> get stream => _stream.stream;

  Future<void> updateStream() async {
    _stream.add(await getTodos());
  }

  //---------------------------------------------------------------------------

  Future<List<TodoItem>> getTodos() async {
    return db.select(db.todoItems).get();
  }

  Future<void> addTodo(String content) async {
    db.into(db.todoItems).insert(
          TodoItemsCompanion.insert(
            content: content,
            createdAt: Value(DateTime.now()),
          ),
        );

    msgService.showSnackBar(message: 'Todo added successfully');
    updateStream();
  }

  Future<void> deleteTodo(int id) async {
    db.todoItems.deleteWhere((tbl) => tbl.id.equals(id));

    msgService.showSnackBar(message: 'Todo deleted successfully');
    updateStream();
  }

  Future<void> updateTodo(int id, String content) async {
    (db.update(db.todoItems)..where((tbl) => tbl.id.equals(id))).write(
      TodoItemsCompanion(
        content: Value(content),
        createdAt: Value(DateTime.now()),
      ),
    );

    msgService.showSnackBar(message: 'Todo updated successfully');
    updateStream();

    naviService.pop();
  }
}
