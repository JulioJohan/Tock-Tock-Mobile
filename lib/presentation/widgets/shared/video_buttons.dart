import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:toktok/config/helpers/human_formats.dart';
import 'package:toktok/domain/datasources/post_datasource.dart';
import 'package:toktok/infrastructure/datasources/post_datasource_imp.dart';
import 'package:toktok/infrastructure/models/post_response.dart';
import 'package:toktok/shared/data/local_video_posts.dart';

class VideoButtons extends StatefulWidget {
  final PostDataSource postDataSource = PostDataSourceImpl();
  // Recibicmos el video
  final Post videoPost;
  bool isLiked = false;
  // final User user;
  VideoButtons({Key? key, required this.videoPost}) : super(key: key);

  @override
  State<VideoButtons> createState() => _VideoButtonsState();
}

class _VideoButtonsState extends State<VideoButtons> {
  late Post videoPost;
  @override
  void initState() {
    super.initState();
    videoPost = widget.videoPost;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.videoPost.numLike);
    return Column(
      children: [
        // Button
        CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(widget.videoPost.user!.avatar)),

        const SizedBox(height: 15),
        if (widget.isLiked == true) ...[
          _CustomIconButton(
              onPressed: (() async {
                widget.isLiked = false;
                Post postUpdate = await widget.postDataSource
                    .subtractLike(widget.videoPost.idPost);
                setState(() {
                  videoPost = postUpdate;
                });
              }),
              value: videoPost.numLike,
              iconColor: Colors.red,
              iconData: Icons.favorite_outline_outlined),
        ],
        if (widget.isLiked == false) ...[
          _CustomIconButton(
              onPressed: (() async {
                widget.isLiked = true;
                Post postUpdate = await widget.postDataSource
                    .sumLike(widget.videoPost.idPost);

                setState(() {
                  videoPost = postUpdate;
                });
              }),
              value: videoPost.numLike,
              iconColor: Colors.red,
              iconData: Icons.favorite),
        ],

        // Separación
        const SizedBox(height: 15),
        _CustomIconButton(
            value: widget.videoPost.numLike,
            iconData: Icons.mode_comment_outlined),
        const SizedBox(height: 15),
        // _CustomIconButton(
        //     value: videoPost.numLike, iconData: Icons.remove_red_eye_outlined),
        // const SizedBox(height: 15),
        // SpinPerfect ayuda a girar el spinner
        SpinPerfect(
            // Duración que de la vulta
            duration: const Duration(seconds: 5),
            infinite: true,
            child: const _CustomIconButton(
                value: 0, iconData: Icons.play_circle_outline))
      ],
    );
  }
}

// Widget para los butones
class _CustomIconButton extends StatelessWidget {
  // Cantidad de likes
  final int value;
  // El iconno del boton
  final IconData iconData;
  // El color es opcional
  final Color? color;

  final VoidCallback? onPressed;

  const _CustomIconButton(
      {super.key,
      required this.value,
      required this.iconData,
      iconColor,
      this.onPressed})
      // Verificando si viene un color si no lo establecemos en blanco
      : color = iconColor ?? Colors.white;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              iconData,
              color: color,
              size: 30,
            )),
        if (value > 0) Text(HumanFormats.humanReadleNumber(value.toDouble()))
      ],
    );
  }
}
