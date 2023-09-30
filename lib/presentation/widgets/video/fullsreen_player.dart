import 'package:flutter/material.dart';
import 'package:toktok/presentation/widgets/video/video_backgroud.dart';
import 'package:video_player/video_player.dart';

class FullScreenPlayer extends StatefulWidget {
  final String videoUrl;
  final String description;
  const FullScreenPlayer(
      {super.key, required this.videoUrl, required this.description});

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  late VideoPlayerController controller;

  @override
  void initState() {
    // Inicar el state
    super.initState();
    //
    //
    // VideoPlayerController.networkUrl(url)
    // Cargar nuestro video
    print(widget.videoUrl);
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..setVolume(0)
      // Siempre quiero que los videos se este reproduciendo
      ..setLooping(true)
      ..initialize().then((value) => {
      // Asegúrate de llamar a setState para que se reconstruya la interfaz y se muestre el video.
      setState(() {})
      })  
      ..play();
  }

  @override
  void dispose() {
    // Elimina los videos que no estoy visualizando
    controller.dispose();
    super.dispose();
  }

  // bool isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Inicializa para nuestros videos
      future: controller.initialize(),
      // snapshot el estado del futere
      builder: (context, snapshot) {
        //
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        }

        // GestureDetector detecta lo que el usuario da click
        return GestureDetector(
          onTap: () {
            if (controller.value.isPlaying) {
              controller.pause();
              return;
            }
            controller.play();
          },
          // AspectRatio es widget p
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            // Video
            child: Stack(
              children: [
                VideoPlayer(controller),
                // Gradiente
                VideoBackgroud(
                  stops: const [0.8, 1.0],
                ),

                // Texto
                Positioned(
                  bottom: 50,
                  left: 20,
                  child: _VideoCaption(caption: widget.description),
                  // child: Text('$c')
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _VideoCaption extends StatelessWidget {
  // El texto
  final String caption;
  //
  const _VideoCaption({super.key, required this.caption});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // context Referiendose a el mismo
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return SizedBox(
      width: size.width * 0.6,
      child: Text(caption, maxLines: 2, style: titleStyle),
    );
  }
}
