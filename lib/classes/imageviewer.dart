import 'dart:typed_data';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:vault/main.dart' as main;
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:share_plus/share_plus.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    final int index = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.grey[700]),
      body: SafeArea(
        bottom: true,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (_) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.share),
                    onTap: () {
                      SharePlus.instance.share(
                        ShareParams(
                          title: 'LockBox Share',
                          files: [XFile(main.activeitem.file.path)],
                        ),
                      );
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.save),
                    onTap: () async {
                      final file = main.activeitem.file;
                      final bytes = await file.readAsBytes();

                      await ImageGallerySaver.saveImage(
                        Uint8List.fromList(bytes),
                        quality: 100,
                        name: file.path.split('/').last,
                      );
                      if (!mounted) return;
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ExtendedImage.file(
              main.activevault!.itemList[index].file,
              fit: BoxFit.contain,
              mode: ExtendedImageMode.gesture,
            ),
          ),
        ),
      ),
    );
  }
}
