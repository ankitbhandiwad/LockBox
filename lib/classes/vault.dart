import 'package:vault/classes/items.dart';
import 'package:flutter/material.dart';
import 'package:vault/main.dart' as main;

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
  

  Vault vault = main.activevault;
  late String userinputfileId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(main.activevault.name),
        actions: [
          ElevatedButton(
            onPressed: () {
              // setState(() {
              //   vaultlist.add(Vault(password: "111", name: "my first vault!"));
              // });

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
                          main.activevault.itemList.add(Item(fileId: userinputfileId));
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

            },
            child: Icon(Icons.add)
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
        itemCount: main.activevault.itemList.length,
        itemBuilder: (context, index)
        {
          return Padding(padding: EdgeInsets.all(8),
            child: Card(
              child: ListTile(
                onTap: () {
                  setState(() {
                    
                  });
                  
                },
                // leading: Icon(Icons.usb),
                title: Text(main.activevault.itemList[index].fileId),
                subtitle: ElevatedButton
                (
                  onPressed: () {
                    setState(() {
                      
                    });
                  },
                  child: Icon(Icons.delete)
                ),
              ),
            ),
          );
        }
        ),
    );
  }
}