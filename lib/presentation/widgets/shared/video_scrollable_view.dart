import 'package:flutter/material.dart';
import 'package:toktok/domain/entities/post_videos.dart';
import 'package:toktok/presentation/widgets/shared/video_buttons.dart';
import 'package:toktok/presentation/widgets/video/fullsreen_player.dart';

class VideoScrollableView extends StatelessWidget {
  final List<VideoPost> videos;

  const VideoScrollableView({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    // PageView Wideget para hacerlo en pantalla completa
    // El builder solo utiliza un video
    // no todos los videos se cargaran rapido
    return PageView.builder(
      // Direccion del page view
      scrollDirection: Axis.vertical,
      // Que se muesra el rebote
      physics: const BouncingScrollPhysics(),
      // Tamaño de los videos
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final VideoPost videosPost = videos[index];

        // El widget Stack ayuda a tener el video de tras y los botones hacia delante
        return Stack(
          children: [
            SizedBox.expand(              
              // El area donde se reproducira el video
              child: FullScreenPlayer(videoUrl: videosPost.videoUrl, caption: videosPost.caption),
            ),
            // FullScreenVideoPlayer()
            
            // Video Player + Gradiente
            // Nos ayuda a posicinar el widget
            Positioned(
              bottom: 40,
              right: 20,
              child: VideoButtons(video: videosPost))
            // Botones
          ],
        );
      },
      // children: [Container(color: Colors.red), Container(color: Colors.blue)],
    );
  }
}
