import 'package:flutter/material.dart';

class NoteEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Screen'),
      ),
      body: const SizedBox(
        height: double.infinity,
        child: TextField(
          maxLines: null,
          expands: true,
        ),
      ),
    );
  }
}
