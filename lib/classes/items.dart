import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Item
{
  late String fileId;
  late dynamic dir;
  late dynamic file;
  void getDirandFile() async
  {
    dir = getApplicationDocumentsDirectory();
    file = File('${dir.path}/$fileId');
  }

  Item({required this.fileId});
}