import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:toktok/config/theme/app_theme.dart';
import 'package:toktok/infrastructure/datasources/post_datasource_imp.dart';
import 'package:toktok/infrastructure/models/post_dto.response.dart';
import 'package:toktok/presentation/widgets/shared/services/camera_gallery_service_impl.dart';
import 'package:video_player/video_player.dart';

class SaveVideo extends StatefulWidget {
  const SaveVideo({super.key});

  @override
  _SaveVideoState createState() => _SaveVideoState();
}

class _SaveVideoState extends State<SaveVideo> {
  ValueNotifier<List<String>> _mediaNotifier =
      ValueNotifier<List<String>>(['assets/videos/2.mp4']);
  // const SaveVideo({super.key});
  final TextEditingController _controller = TextEditingController();
  String? _errorMessage = '';
  static const String desciptionLabel =
      'Crear contenido más inormativo entrando en más detalles con 4000 caracteres';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.text.length > 200) {
        setState(() {
          _errorMessage =
              'La descripción ha alcanzado el límite de 200 caracteres';
        });
      } else {
        setState(() {
          _errorMessage = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
      title: 'Publicar',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Publicar'),
          // actions: <Widget>[
          //   IconButton(
          //     icon: const Icon(Icons.send),
          //     onPressed: () {},
          //   ),
          // ],
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(
              width: 250,
              height: 100,
              child: TextField(
                maxLength: 200,
                controller: _controller,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                // obscureText: true,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Descripción',
                ),
              ),
            ),

            SizedBox(
              height: 10,
              width: 100,
            ),

            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.white),
              ),

            // SizedBox(
            //   height: 250,
            //   width: 600,
            //   child: _iM,
            // ),
            ElevatedButton.icon(
              icon: const Icon(Icons.video_call_outlined,
                  color: Colors.white,
                  textDirection: TextDirection
                      .rtl), // Esto agregará un ícono a la derecha del texto
              label: const Text('Tomar video',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white)),
              onPressed: () async {
                final photoPath = await CameraGaleryServiceImpl().takeVideo();
                if (photoPath == null) return;
                print(photoPath);
                setState(() {});
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple)),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.photo_library_outlined,
                  color: Colors.white,
                  textDirection: TextDirection
                      .rtl), // Esto agregará un ícono a la derecha del texto
              label: const Text('Seleccionar video',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white)),
              onPressed: () async {
                final photoPath = await CameraGaleryServiceImpl().selectVideo();
                if (photoPath == null) return;
                setState(() {
                  _mediaNotifier.value = [photoPath];
                });
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple)),

              // onPressed: () {},
              // style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent)),
              // child: const  Text('Seleccionar foto o video',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.upload_outlined,
                  color: Colors.white,
                  textDirection: TextDirection
                      .rtl), // Esto agregará un ícono a la derecha del texto
              label: const Text('Publicar',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white)),
              onPressed: () async {
                final post = PostDto(description: _controller.text, user: 2);
                // Obtener la ruta del video
                final videoPath = _mediaNotifier.value[0];

                if (videoPath.contains('assets/videos/2.mp4')) return;

                // Llamar a savePost
                final postRespuesta =
                    await PostDataSourceImpl().savePost(post, videoPath);
                context.go('/home/0');
                // PostDto(description: description, multimedia: multimedia, user: user)
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple)),

              // onPressed: () {},
              // style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent)),
              // child: const  Text('Seleccionar foto o video',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
            ),
            SizedBox(
              height: 300,
              width: 300,
              child: _mediaNotifier.value.isNotEmpty
                  ? _ImageGallery(mediaNotifier: _mediaNotifier)
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageGallery extends StatefulWidget {
  // final List<String>? media;
  final ValueNotifier<List<String>> mediaNotifier;
  const _ImageGallery({required this.mediaNotifier});

  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<_ImageGallery> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // print('Nuevo video' + widget.media[0]);
    super.initState();
    widget.mediaNotifier.addListener(_initializeVideoPlayer);
    _initializeVideoPlayer();
    // _controller = VideoPlayerController.asset(widget.media[0])
    //   ..setVolume(0)
    //   ..setLooping(true)
    //   ..play();
    // _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    widget.mediaNotifier.removeListener(_initializeVideoPlayer);
    _controller.dispose();
    super.dispose();
  }

  void _initializeVideoPlayer() {
    // print('aaaaaaaaaaaaaaaaaaaaaaaaaaa'+widget.mediaNotifier.value[0]);
    // print('aaaaaaaaaaaaaaaaaaaaaaaaaaa'+widget.mediaNotifier.value.length.toString());
    if (widget.mediaNotifier.value[0].contains('assets/videos/2.mp4')) {
      _controller = VideoPlayerController.asset(widget.mediaNotifier.value[0])
        ..setVolume(100)
        ..setLooping(true)
        ..play();
      _initializeVideoPlayerFuture = _controller.initialize();
    }

    _controller =
        VideoPlayerController.file(File(widget.mediaNotifier.value[0]))
          ..setVolume(100)
          ..setLooping(true)
          ..play();
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.mediaNotifier.value.isEmpty) {
      return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Image.asset('assets/images/video_no_encontrado.jpg',
              fit: BoxFit.cover));
    }

    return PageView(
      scrollDirection: Axis.horizontal,
      controller: PageController(viewportFraction: 0.7),
      children: widget.mediaNotifier.value.map((media) {
        print(media);
        if (media.endsWith('.mp4')) {
          print(media);
          print("object");
          return ClipRRect(
            borderRadius: BorderRadius.circular(20), // Radio de los bordes
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          );
        } else {
          late ImageProvider imageProvider;
          if (media.startsWith('http')) {
            imageProvider = NetworkImage(media);
          } else {
            imageProvider = FileImage(File(media));
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: FadeInImage(
                  fit: BoxFit.cover,
                  image: imageProvider,
                  placeholder:
                      const AssetImage('assets/loaders/bottle-loader.gif'),
                )),
          );
        }
      }).toList(),
    );
  }
}
