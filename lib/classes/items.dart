import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Item
{
  late String fileId;
  late dynamic dir;
  late dynamic file;
  late String type;
  void getDirandFile() async
  {
    dir = await getApplicationDocumentsDirectory();
    file = File('${dir.path}/$fileId');
  }

  Item({required this.fileId, required this.type});
}