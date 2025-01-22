import 'package:flutter/material.dart';
import 'package:practice_flutter_drift/components/text_editor.dart';
import 'package:practice_flutter_drift/database/database.dart';
import 'package:practice_flutter_drift/main.dart';

class TodoItemWidget extends StatelessWidget {
  const TodoItemWidget({
    super.key,
    required this.item,
  });

  final TodoItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.content,
                style: const TextStyle(fontSize: 16, height: 1.8),
              ),
              Text(
                item.createdAt.toString().substring(0, 22),
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.refresh_rounded),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 32,
                  ),
                  height: double.infinity,
                  width: double.infinity,
                  child: TextEditor(
                    initText: item.content,
                    onSubmit: (text) {
                      dbService.updateTodo(item.id, text);
                    },
                  ),
                );
              },
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            dbService.deleteTodo(item.id);
          },
        ),
      ],
    );
  }
}
