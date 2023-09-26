import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullScreenPlayer extends StatefulWidget {
  final String videoUrl;
  final String caption;
  const FullScreenPlayer(
      {super.key, required this.videoUrl, required this.caption});

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  late VideoPlayerController controller;


  // Inicar el state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  // bool isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
