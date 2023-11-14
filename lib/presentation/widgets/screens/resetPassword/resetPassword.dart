import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:toktok/presentation/widgets/screens/resetPassword/Controller/resetPassword_controller.dart';

final  resetPasswordProvider= SimpleProvider(
  (_)=>ResetPasswordController(),
);

final FirebaseAuth _auth = FirebaseAuth.instance;

class ResetPasswordPage extends StatefulWidget {
  static const String name = 'resetPassword';

  const ResetPasswordPage({super.key});

  @override
  _ResetPasswordPage createState() => _ResetPasswordPage();

}

class _ResetPasswordPage extends State<ResetPasswordPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> submit(email) async{
    return sendResetPasswordLink(email);
  }
  
  Future<void> _returnLogin() async {
    context.go('/login');
  }

  Future<String?> sendResetPasswordLink(String email)async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch(e){
      return e.code;
    }
  }

  void showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  void _showAlert(String title, String message, int resultado) {
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
                if (resultado==1){
                  _returnLogin();
                }else{
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProviderListener<ResetPasswordController>(
      provider: resetPasswordProvider,
      builder: (_,controller)=> Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: GestureDetector(
            onTap: ()=> FocusScope.of(context).unfocus(),
            child: Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget> [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextField(
                      onChanged: controller.onEmailChanged,
                      decoration: InputDecoration(
                      hintText: 'Correo',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: ()=>_submit(context), 
                    child: Text("Restablecer"),
                  ),
                  const SizedBox(height:30),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  void _submit(BuildContext context)async{
    final controller = resetPasswordProvider.read;
    //if (isValidEmail(controller.email)){
    if(controller.email.isNotEmpty){
      String email = controller.email;
      showLoaderDialog(context);
      final error = await submit(controller.email);
      Navigator.pop(context);
      if (error== null){
        _showAlert('ENVIADO!', 'Te enviamos un correo a $email.',1);
      }else{
        _showAlert('ERROR!', 'Email Inválido', 2);
      }
    }else{
     _showAlert('Correo Inválido', 'Ingrese un correo válido',2);
    }
    controller.onEmailChanged('');
  }
}
