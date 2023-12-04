import 'package:toktok/infrastructure/models/user_response.dart';

abstract class UserDataSource {
  Future<User?> getUserByEmail(String email);
  Future<User?> saveUser(String nombre, String email);
}
