import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toktok/config/theme/app_theme.dart';
import 'package:toktok/presentation/widgets/shared/services/camera_gallery_service_impl.dart';

class SaveVideo extends StatefulWidget {
  const SaveVideo({super.key});

  @override
  _SaveVideoState createState() => _SaveVideoState();
}

class _SaveVideoState extends State<SaveVideo> {
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
              icon: const Icon(Icons.camera_alt_outlined,
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
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple)),

              // onPressed: () {},
              // style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent)),
              // child: const  Text('Seleccionar foto o video',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
            ),
             SizedBox(
              height: 10 ,
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
                photoPath;
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
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple)),

              // onPressed: () {},
              // style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent)),
              // child: const  Text('Seleccionar foto o video',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
