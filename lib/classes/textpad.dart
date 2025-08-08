import 'package:flutter/material.dart';
import 'package:vault/main.dart' as main;

class Textpad extends StatefulWidget {
  const Textpad({super.key});

  @override
  State<Textpad> createState() => _TextpadState();
}

class _TextpadState extends State<Textpad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(main.activeitem.fileId),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox.expand(
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            expands: true,
          ),
        ),
      ),
    );
  }
}