import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class RegistroPage extends StatefulWidget {
  static const String name = '/';

  @override
  _RegistroPage createState() => _RegistroPage();
}

class _RegistroPage extends State<RegistroPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _createUser() async {
    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        _showAlert(
            'Campos requeridos', 'Por favor, completa todos los campos.');
        return;
      }

      final UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = authResult.user;

      if (user != null) {
        // Iniciar sesión con éxito, redirigir a la página principal.
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } catch (error) {
      print(error);
      _showAlert('Error de inicio de sesión',
          'El correo o la contraseña son incorrectos.');
    }
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
              child: const Text('OK'),
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
        title: const Text('Registro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Correo',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Contraseña',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _createUser();
              },
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
