// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:better_player_plus/better_player_plus.dart';
import 'package:vault/main.dart' as main;

class VideoView extends StatefulWidget {
  const VideoView({super.key});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  @override
  Widget build(BuildContext context) {
    final file = main.activeitem.file;
    final betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        fit: BoxFit.contain,
        autoPlay: false,
        looping: false,
        subtitlesConfiguration: BetterPlayerSubtitlesConfiguration(
          fontSize: 16,
          fontColor: Colors.white,
          outlineEnabled: true,
          outlineColor: Colors.black,
        ),
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableSubtitles: true,
          enablePlaybackSpeed: true,
          enableProgressText: true,
          enableSkips: true,
        ),
      ),
      betterPlayerDataSource: BetterPlayerDataSource(
        BetterPlayerDataSourceType.file,
        file.path,
      ),
    );


    return Scaffold(
      body: BetterPlayer(controller: betterPlayerController),
    );
  }
}