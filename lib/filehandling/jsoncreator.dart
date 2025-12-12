import 'package:vault/main.dart' as main;
// import 'package:vault/classes/items.dart';
import 'package:vault/classes/vault.dart';
// import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

class Jsoncreator {
  // printvaultlist() async { 
  //   for (var element in main.vaultlist) {
  //     // print(element);
  //   }
  //   final dir = await getApplicationDocumentsDirectory();
  //   final file = File('${dir.path}/vaultdata.json');
  //   // print('JSON FULL PATH = ${file.path}');


  // }

  String encodeVaultList(List<Vault> vaults) {
    return jsonEncode(vaults.map((v) => v.toJson()).toList());
  }

  Future<void> editjson() async {
    dynamic dir = await getApplicationDocumentsDirectory();
    File vaultdatafile = File('${dir.path}/vaultdata.json');

    final jsonString = encodeVaultList(main.vaultlist);
    await vaultdatafile.writeAsString(jsonString);
  }

  Future<List<Vault>> loadVaultList() async
  {
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/vaultdata.json');

  if (!await file.exists()) return [];

  final text = await file.readAsString();
  final data = jsonDecode(text) as List;

  return data.map((e) => Vault.fromJson(e)).toList();
  }
}
