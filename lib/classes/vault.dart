import 'dart:ffi';

import 'package:vault/classes/items.dart';
import 'package:flutter/material.dart';
import 'package:vault/main.dart' as main;
import 'package:insta_image_viewer/insta_image_viewer.dart';

class Vault
{
  late String password;
  List<Item> itemList = [];
  late String name;

  Vault({required this.password, required this.name});

  void addFile(Item item)
  {
    itemList.add(item);
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
                onSelected: (value)
                {
                  if (value == 'text')
                  {
                    showDialog(context: context,
                    builder: (BuildContext context)
                    {
                      return AlertDialog(
                        content: Column(
                          children: [
                            TextField( //userinputname
                              decoration: InputDecoration(
                                hintText: 'Item Name'
                              ),
                              onChanged: (value)
                              {
                                setState(() {
                                  userinputfileId = value;
                                });
                              },
                            ),
                            ElevatedButton( //dialog submit button
                              onPressed: () {
                              setState(() {
                                main.activevault!.itemList.add(Item(fileId: userinputfileId, type: 'text'));
                              });
                              Navigator.of(context).pop();
                            },
                            child: Text("Submit"),
                            )
                            
                          ],
                        ),
                      );
                    }
                    );
                  }
                  if (value == 'image')
                  {
                    print('chose image');
                    setState(() {
                      main.activevault!.itemList.add(Item(fileId: 'test image', type: 'image'));
                    });
                  }
                },
                itemBuilder: (context) =>
                [
                  const PopupMenuItem(
                    value: 'text',
                    child: Text('Text'),
                  ),
                  const PopupMenuItem(
                    value: 'image',
                    child: Text('Image'),
                  ),
                ],
                child: Icon(Icons.add),
              ),

        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
        itemCount: main.activevault!.itemList.length,
        itemBuilder: (context, index)
        {
          return Padding(padding: EdgeInsets.all(8),
            child: Card(
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
                      if (main.activeitem.type == 'image')
                      {
                        // Navigator.pushNamed(context, '/imageview');
                  
                      }
                    },
                    title: Text(main.activevault!.itemList[index].fileId),
                    subtitle: ElevatedButton
                    (
                      onPressed: () async {
                        if (await main.activevault!.itemList[index].file.exists())
                          {
                            await main.activevault!.itemList[index].file.delete();
                          }
                        setState(() {
                          main.activevault!.itemList.removeAt(index);
                        });
                      },
                      child: Icon(Icons.delete)
                    ),
                  ),
                  SizedBox(
                    child: main.activevault!.itemList[index].type == 'image' ?
                    AspectRatio(aspectRatio: 1,
                    child: InstaImageViewer(child: Image.network("https://picsum.photos/id/507/1000", fit: BoxFit.cover,)))
                  : Container(),
                  ),
                ],
              ),
            ),
          );
        }
        ),
    );
  }
}