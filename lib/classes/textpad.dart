import 'package:flutter/material.dart';
import 'package:vault/main.dart' as main;
// import 'dart:io';

class Textpad extends StatefulWidget {
  const Textpad({super.key});
  @override
  
  State<Textpad> createState() => _TextpadState();
  
  
}



class _TextpadState extends State<Textpad> {
  @override
    void initState() {
    super.initState();
    _loadFile();
  }


  final _controller = TextEditingController();

  Future<void> _loadFile() async
  {
    if (await main.activeitem.file.exists())
    {
      final contents = await main.activeitem.file.readAsString();
      _controller.text = contents;
    }
  }

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
            controller: _controller,
            onChanged: (input)
            {
              main.activeitem.file.writeAsString(input);
            },
          ),
        ),
      ),
    );
  }
}