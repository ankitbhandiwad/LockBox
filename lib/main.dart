import 'package:flutter/material.dart';
import 'package:vault/classes/items.dart';
import 'package:vault/classes/textpad.dart';
import 'package:vault/classes/vault.dart';

void main()
{
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/vault': (context) => VaultPage(),
      '/textpad': (context) => Textpad(),
    },
  )
  );
}

List<Vault> vaultlist = [];
late Vault? activevault;
late Vault? activevaultpass;
late Item activeitem;
late String userinputname;
late String userinputpassword;
late String userinputguess;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
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
                          hintText: 'Vault Name'
                        ),
                        onChanged: (value)
                        {
                          setState(() {
                            userinputname = value;
                          });
                        },
                      ),
                      TextField( //userinputpassword
                        decoration: InputDecoration(
                          hintText: 'Vault Password'
                        ),
                        onChanged: (value)
                        {
                          setState(() {
                            userinputpassword = value;
                          });
                        },
                      ),
                      ElevatedButton(
                        onPressed: ()
                        {
                        setState(() {
                          vaultlist.add(Vault(password: userinputpassword, name: userinputname));
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
        itemCount: vaultlist.length,
        itemBuilder: (context, index)
        {
          return Padding(padding: EdgeInsets.all(8),
            child: Card(
              child: ListTile(
                onTap: () {
                  setState(() {
                    activevaultpass = vaultlist[index];
                  });
                  showDialog(context: context,
                    builder: (BuildContext context)
                    {
                      return AlertDialog(
                        content: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Vault Password',
                              ),
                              onChanged: (value) {
                                userinputguess = value;
                              }
                            ),
                              ElevatedButton(onPressed: () {
                                if (userinputguess == activevaultpass!.password)
                                {
                                  setState(() {
                                    activevault = vaultlist[index];
                                    activevaultpass = null;
                                  });
                                  Navigator.of(context).pop();
                                  Navigator.pushNamed(context, '/vault');
                                }
                                else
                                {
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text("Submit"))
                          ],
                        )
                      );
                    }
                    );

                },
                // leading: Icon(Icons.usb),
                title: Text(vaultlist[index].name),
                subtitle: ElevatedButton
                (
                  onPressed: () {
                    setState(() {
                      vaultlist.removeAt(index);
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