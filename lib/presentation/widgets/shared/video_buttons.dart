import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:toktok/config/helpers/human_formats.dart';
import 'package:toktok/domain/entities/post_videos.dart';

class VideoButtons extends StatelessWidget {
  // Recibicmos el video
  final VideoPost video;
  const VideoButtons({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Button
        _CustomIconButton(
            value: video.likes,
            iconColor: Colors.red,
            iconData: Icons.favorite),
        // Separación
        const SizedBox(height: 20),
        _CustomIconButton(
            value: video.views, iconData: Icons.remove_red_eye_outlined),
        const SizedBox(height: 20),
        // SpinPerfect ayuda a girar el spinner
        SpinPerfect(
          // Duración que de la vulta
          duration: const Duration(seconds: 5),
          infinite: true,
          child: const _CustomIconButton(value: 0, iconData: Icons.play_circle_outline))
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

  const _CustomIconButton(
      {super.key, required this.value, required this.iconData, iconColor})
      // Verificando si viene un color si no lo establecemos en blanco
      : color = iconColor ?? Colors.white;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
            onPressed: () {},
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
