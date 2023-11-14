// ignore: file_names
import 'package:flutter_meedu/meedu.dart';
import 'package:meedu/src/instance_manager/instance_manager.dart';
import 'package:toktok/presentation/widgets/screens/resetPassword/resetPassword.dart';

class ResetPasswordController extends SimpleNotifier{
  String _email = '';
  String get email => _email;
  
  void onEmailChanged(String text){
    _email = text;
  }


}