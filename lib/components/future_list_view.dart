import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:practice_flutter_drift/components/todo_item.dart';
import 'package:practice_flutter_drift/database/database.dart';

class FutureListView<T> extends StatelessWidget {
  const FutureListView({
    super.key,
    required this.stream,
  });

  final Stream<List<T>> stream;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            log(snapshot.stackTrace.toString());
            return Text('Error: ${snapshot.error}');
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final item = snapshot.data?[index];

              switch (item.runtimeType) {
                case const (TodoItem):
                  return TodoItemWidget(item: item as TodoItem);
              }

              return null;
            },
          );
        },
      ),
    );
  }
}
