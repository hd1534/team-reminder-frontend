import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  TextInputWidget({super.key});

  // TODO: When focusing out, it loses its data
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        minLines: 1,
        maxLines: 4,
        controller: _textController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(Icons.send),
            onPressed: send,
          ),
        ),
      ),
    );
  }
}

void send() {}
