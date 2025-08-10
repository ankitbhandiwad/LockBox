import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InstaImageViewer(
          child: Image(
            image: Image.network("https://picsum.photos/id/507/1000").image,
          ),
        ),
      ),
    );
  }
}