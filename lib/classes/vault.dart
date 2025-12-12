// import 'dart:ffi';
import 'dart:io';
import 'package:vault/classes/items.dart';
import 'package:flutter/material.dart';
import 'package:vault/main.dart' as main;
// import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:vault/filehandling/jsoncreator.dart' as jsoncreate;
// import 'package:extended_image/extended_image.dart';

class Vault {
  late String password;
  List<Item> itemList = [];
  late String name;

  Vault({required this.password, required this.name});
  Vault.withList({
    required this.password,
    required this.name,
    required this.itemList,
  });

  void addFile(Item item) {
    itemList.add(item);
  }

  @override
  String toString() {
    return 'Vault(name: $name, password: $password, items: $itemList)';
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'password': password,
      'items': itemList.map((i) => i.toJson()).toList(),
    };
  }

  factory Vault.fromJson(Map<String, dynamic> json) {
    return Vault.withList(
      name: json['name'],
      password: json['password'],
      itemList: (json['items'] as List).map((e) => Item.fromJson(e)).toList(),
    );
  }
}

class VaultPage extends StatefulWidget {
  const VaultPage({super.key});

  @override
  State<VaultPage> createState() => _VaultPageState();
}

class _VaultPageState extends State<VaultPage> {
  Vault vault = main.activevault!;
  late String userinputfileId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(main.activevault!.name),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'text') {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Column(
                        children: [
                          TextField(
                            //userinputname
                            decoration: InputDecoration(hintText: 'Item Name'),
                            onChanged: (value) {
                              setState(() {
                                userinputfileId = value;
                              });
                            },
                          ),
                          ElevatedButton(
                            //dialog submit button
                            onPressed: () {
                              setState(() {
                                main.activevault!.itemList.add(
                                  Item(fileId: userinputfileId, type: 'text'),
                                );
                                jsoncreate.Jsoncreator().editjson();
                              });
                              Navigator.of(context).pop();
                            },
                            child: Text("Submit"),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              if (value == 'image') {
                // print('chose image');
                // setState(() {
                //   main.activevault!.itemList.add(Item(fileId: 'test image', type: 'image'));
                // });
                FilePickerResult? file = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                );
                if (file != null) {
                  // main.activevault!.itemList.add(Item(fileId: file.names[0]))
                  for (int i = 0; i < file.count; i++) {
                    setState(() {
                      main.activevault!.itemList.add(
                        Item(fileId: file.names[i]!, type: "image"),
                      );
                    });
                    await main.activevault!.itemList.last.getDirandFile();
                    dynamic destination =
                        '${main.activevault!.itemList.last.dir.path}/${main.activevault!.itemList.last.fileId}';
                    dynamic source = File(file.paths[i]!);
                    main.activevault!.itemList.last.file = File(destination);
                    await source.copy(destination);
                    setState(() {
                      jsoncreate.Jsoncreator().editjson();
                    });
                  }
                }
              }
              if (value == 'video') {
                FilePickerResult? file = await FilePicker.platform.pickFiles(
                  type: FileType.video,
                  // allowedExtensions: [
                  //   // video
                  //   'mp4', 'mkv', 'avi', 'mov', 'wmv', 'flv', 'webm', 'mpeg', 'mpg', '3gp', 'm4v', 'ts',
                  //   // audio
                  //   'mp3', 'wav', 'aac', 'flac', 'ogg', 'm4a', 'wma', 'opus', 'aiff', 'alac',
                  // ]
                );
                if (file != null) {
                  for (int i = 0; i < file.count; i++) {
                    setState(() {
                      main.activevault!.itemList.add(
                        Item(fileId: file.names[i]!, type: "video"),
                      );
                    });
                    await main.activevault!.itemList.last.getDirandFile();
                    dynamic destination =
                        '${main.activevault!.itemList.last.dir.path}/${main.activevault!.itemList.last.fileId}';
                    dynamic source = File(file.paths[i]!);
                    // main.activevault!.itemList.last.dir = destination;
                    await source.copy(destination);
                    setState(() {
                      jsoncreate.Jsoncreator().editjson();
                    });
                  }
                }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'text', child: Text('Text')),
              const PopupMenuItem(value: 'image', child: Text('Image')),
              const PopupMenuItem(value: 'video', child: Text('Video/Audio')),
            ],
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: main.activevault!.itemList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: Card(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                      onTap: () {
                        setState(() {
                          main.activeitem = main.activevault!.itemList[index];
                        });
                        if (main.activeitem.type == 'text') //text editor
                        {
                          main.activeitem.getDirandFile();
                          Navigator.pushNamed(context, '/textpad');
                        }
                        if (main.activeitem.type == 'image') {
                          Navigator.pushNamed(context, '/imageview',
                          arguments: index,
                          );
                        }
                        if (main.activeitem.type == 'video') {
                          Navigator.pushNamed(context, '/videoview');
                        }
                      },
                      title: Text(main.activevault!.itemList[index].fileId),
                      subtitle: ElevatedButton(
                        onPressed: () async {
                          if (await main.activevault!.itemList[index].file
                              .exists()) {
                            await main.activevault!.itemList[index].file
                                .delete();
                          }
                          setState(() {
                            main.activevault!.itemList.removeAt(index);
                            jsoncreate.Jsoncreator().editjson();
                          });
                        },
                        child: Icon(Icons.delete),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: main.activevault!.itemList[index].type == 'image'
                          // ? InstaImageViewer(
                          //     child: Image.file(
                          //       main.activevault!.itemList[index].file,
                          //       fit: BoxFit.contain,
                          //     ),
                          //   )
                          // ? ExtendedImage.file(
                          //   main.activevault!.itemList[index].file,
                          //   mode: ExtendedImageMode.gesture
                          // )
                          ? Container()
                          : Container(), //thumbnail
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
