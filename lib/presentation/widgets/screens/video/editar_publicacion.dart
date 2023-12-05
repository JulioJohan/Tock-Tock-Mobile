import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toktok/infrastructure/datasources/post_datasource_imp.dart';
import 'package:toktok/infrastructure/models/post_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fluttertoast/fluttertoast.dart';



class EditPublicacion extends StatefulWidget {
  const EditPublicacion({super.key});

  @override
  _SaveVideoState createState() => _SaveVideoState();
}

class _SaveVideoState extends State<EditPublicacion> {
  late Future<List<Post>> _loadVideosFuture;
   bool cargando = false;
   //Variable para controlar el texto editado.
   final TextEditingController _editingController = TextEditingController();


  @override
  void initState() {
    super.initState();

    _loadVideosFuture = loadNextPage();
  }

  final PostDataSourceImpl postRepository = PostDataSourceImpl();

  List<Post> videos = [];
  String? nombre ="";

  Future<List<Post>> loadNextPage() async {
    videos=[];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');
    print(id);
    nombre = prefs.getString('nombre');
    final newVideos = await postRepository.findByUserPost(id!, "1");
    videos.addAll(newVideos);

    //Forzar la recontruccion del widget
    setState(() {});

    return videos;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffffffff),
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          // backgroundColor: const Color(0xffffffff),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          title: const Text(
            "Perfil",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              fontSize: 20,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 80,
                width: 80,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                    "https://icon-library.com/images/icon-user/icon-user-15.jpg",
                    fit: BoxFit.cover),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                child: Text(
                  nombre!,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                          child: Text(
                            "",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Divider(
                color: Color(0xffd5d5d5),
                height: 10,
                thickness: 0.5,
                indent: 0,
                endIndent: 0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Mis videos",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
ListView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                //Aquí está la lista de videos
                children: [
                  FutureBuilder<List<Post>>(
                    future: _loadVideosFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Error cargando videos');
                        } else {
                          // Datos cargados correctamente, llama a cargarVideos
                          return ListView(
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: cargarVideos(),
                          );
                        }
                      } else {
                        // Indicador de carga
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Row> cargarVideos() {
    List<Row> listaVideos = [];

    // loadNextPage();
    print("Numero de videos");
    print(videos.length);
    
    for (int i = 0; i < videos.length; i++) {
      Post? video= videos[i];

      Row renglon = Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                const Image(
              image: NetworkImage(
                  "https://www.clipartbest.com/cliparts/niB/MMy/niBMMyEXT.png"),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
           Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    video.description,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color.fromARGB(255, 229, 230, 234),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: Text(
                      video.dateRegistration.toString().substring(0, 11),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xbe8a8989),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          PopupMenuButton<int>(
            icon: const Icon(
              Icons.more_vert,
              color: Color.fromARGB(255, 255, 255, 255),
              size: 24,
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: Text('Editar'),
              ),
              const PopupMenuItem(
                value: 2,
                child: Text('Eliminar'),
              ),
            ],
            onSelected: (value) {
              if (value == 1) {
                print('Editar'+ video.idPost.toString());
                // Aquí puedes definir la acción que se realizará al seleccionar 'Editar'
                  _editingController.text = video.description;
                  _showEditDialog(video);
              } else if (value == 2) {
                print('Eliminar'+ video.idPost.toString());
                eliminarVideo(video.idPost);
                // Aquí puedes definir la acción que se realizará al seleccionar 'Eliminar'
              }
            },
          )
        ],
      );
      listaVideos.add(renglon);
    }
    // print("Numero de lista " + listaVideos.length.toString());
    return listaVideos;
  }

  
  // En el método _SaveVideoState
  void eliminarVideo(int id) async {
  try {
    // Establecer el estado de cargando a true antes de la operación
    setState(() {
      cargando = true;
    });

    // Realiza la lógica de eliminación aquí, como una petición HTTP DELETE
    final String mensaje = await postRepository.deletePost(id);

    // Mostrar mensaje de video eliminado
    // Fluttertoast.showToast(
    //   msg: mensaje,
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   backgroundColor: Colors.black,
    //   textColor: Colors.white,
    // );

    // Actualizar la lista y volver a cargar los videos
    await loadNextPage(); // O la lógica que necesites para recargar la lista

    // Este setState() fuerza la reconstrucción del widget y establece cargando a false
    setState(() {
      cargando = false;
    });
    _showAlertDialog("OK", mensaje);

  } catch (e) {
    // Manejar errores, si es necesario
    print('Error al eliminar el video: $e');
    // También establecer cargando a false en caso de error
    setState(() {
      cargando = false;
    });
  }
}

void _showAlertDialog(String titulo, String mensaje) {
    showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("CERRAR", style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

//Metodo para crear mostrar un dialogo de editar el video
void _showEditDialog(Post post) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Editar Video'),
        content: TextField(
          controller: _editingController,
          maxLength: 50, // Define el número máximo de caracteres permitidos
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          decoration: const InputDecoration(hintText: 'Nueva descripción'),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              _updateVideoDescription(post);
              Navigator.pop(context);
            },
            child: const Text('Guardar'),
          ),
        ],
      );
    },
  );
}

void _updateVideoDescription(Post post) async {
  try {
    // Lógica para enviar la nueva descripción al servidor (puedes usar postRepository.updateDescription, por ejemplo)
    print(_editingController.text);
    post.description=_editingController.text;
        // Realiza la lógica de eliminación aquí, como una petición HTTP DELETE
    final String mensaje = await postRepository.updatePost(1, post);
    // Volver a cargar la lista de videos después de la actualización
    await loadNextPage();

    // Forzar la reconstrucción del widget
    setState(() {});
    _showAlertDialog("OK", mensaje);

  } catch (e) {
    print('Error al actualizar la descripción: $e');
        _showAlertDialog("Error", "Error al actualizar la descripción");

  }
}



}
