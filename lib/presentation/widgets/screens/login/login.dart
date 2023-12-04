import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toktok/infrastructure/datasources/user_datasource_imp.dart';

class LoginPage extends StatefulWidget {
  static const String name = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final UserDataSourceImpl userRepository = UserDataSourceImpl();


  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _handleEmailSignIn() async {
    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        _showAlert(
            'Campos requeridos', 'Por favor, completa todos los campos.');
        return;
      }

      final UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = authResult.user;

      if (user != null) {
        try{
              final newVideos = await userRepository.getUserByEmail(email);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('id', newVideos!.idUser.toString());
              await prefs.setString('nombre', newVideos.name);

              context.go('/home/0');
        }catch(error){
          _showAlert('Error de inicio de sesión',
          'El correo o la contraseña son incorrectos.');
        }
        // Iniciar sesión con éxito, redirigir a la página principal.
        context.go('/home/0');
      }
    } catch (error) {
      print(error);
      _showAlert('Error de inicio de sesión',
          'El correo o la contraseña son incorrectos.');
    }
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      if (user != null) {
        // Iniciar sesión con éxito, redirigir a la página principal.
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } catch (error) {
      print(error);
      _showAlert(
          'Error de inicio de sesión', 'Error al iniciar sesión con Google.');
    }
  }

  Future<void> _registrarse() async {
    context.go('/registro');
  }

  Future<void> _resetPassword() async {
    context.go('/resetPassword');
  }

  void _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Correo',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _handleEmailSignIn();
              },
              child: Text('Ingresar'),
            ),
            ElevatedButton(
              onPressed: () {
                _handleGoogleSignIn();
              },
              child: Text('Ingresar con Google'),
            ),
            ElevatedButton(
              onPressed: () {
                _registrarse();
              },
              child: Text('Registrarse'),
            ),
            ElevatedButton(onPressed: (){
              _resetPassword();
            }, child: Text('Recuperar Contraseña')
            )
          ],
        ),
      ),
    );
  }
}
