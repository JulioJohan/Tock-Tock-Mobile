import 'package:flutter/material.dart';

class VideoBackgroud extends StatelessWidget {
  final List<Color> colors;
  // Donde incian el background
  final List<double> stops;

  const VideoBackgroud(
      {super.key,
      this.colors = const [Colors.transparent, Colors.black87],
      this.stops = const [0.0, 1.0]})
      : assert(colors.length == stops.length,
            'Stop and Colors must be same lenght');

  @override
  Widget build(BuildContext context) {
    // Toma todo el espacio posible
    return Positioned.fill(
        child: DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              // Colores en el fondo
              colors: colors,
              //
              stops: stops,
              // Donde estara posicionado el gradiante
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
    ));
  }
}
