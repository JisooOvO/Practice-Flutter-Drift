import 'package:flutter/material.dart';

class TextEditor extends StatefulWidget {
  const TextEditor({
    super.key,
    this.initText = '',
    required this.onSubmit,
  });

  final String initText;
  final Function(String) onSubmit;

  @override
  State<TextEditor> createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initText;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        labelText: 'Enter a task',
      ),
      onSubmitted: (text) async {
        _controller.clear();
        widget.onSubmit(text);
      },
    );
  }
}
