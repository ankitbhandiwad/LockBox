import 'dart:io';
import 'package:path_provider/path_provider.dart';
// import 'package:isar/isar.dart';
// part 'item.g.dart';


class Item {
  late String fileId;
  late Directory dir;
  late File file;
  late String type;
  Future<void> getDirandFile() async {
    dir = await getApplicationDocumentsDirectory();
    file = File('${dir.path}/$fileId');
  }

  @override
  String toString() {
    return 'Item(fileId: $fileId, dir: $dir, file: $file, type: $type)';
  }

  Map<String, dynamic> toJson() {
    return {'fileId': fileId, 'dir': dir.path, 'file': file.path, 'type': type};
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item.withFile(
      fileId: json['fileId']!,
      dir: Directory(json['dir']!),
      file: File(json['file']!),
      type: json['type']!,
    );
  }

  Item({required this.fileId, required this.type});
  Item.withFile({required this.fileId, required this.type, required this.file, required this.dir});
}
