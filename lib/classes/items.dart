import 'dart:io';
import 'package:path_provider/path_provider.dart';
// import 'package:isar/isar.dart';
// part 'item.g.dart';


// @collection
class Item
{

  // Id id = Isar.autoIncrement;

  late String fileId;
  late dynamic dir;
  late dynamic file;
  late String type;
  Future<void> getDirandFile() async
  {
    dir = await getApplicationDocumentsDirectory();
    file = File('${dir.path}/$fileId');
  }

  Item({required this.fileId, required this.type});
}