import 'dart:io';

import 'package:dio/dio.dart';
import 'package:toktok/config/enviroments/enviroments.dart';
import 'package:toktok/domain/datasources/user_datasource.dart';
import 'package:toktok/infrastructure/models/response.dart';
import 'package:toktok/infrastructure/models/user_response.dart';

class UserDataSourceImpl implements UserDataSource {
  final enviroment = Enviroment();
  ResponseData<User> responseUser =
      ResponseData(status: "", message: "", list: [], count: 0);



  @override
  Future<User?> getUserByEmail(String email) async {
        String url = '${enviroment.getUrl()}/user/findUserByEmail/$email';
        print(url);
        final response = await Dio().get(url);
        // print(response.data['list']);
        responseUser = ResponseData<User>.fromJson(
            response.data, (json) => User.fromJson(json));
        final User? listPost = responseUser.data;
        print(listPost);
        return listPost;
  }

  @override
  Future<User?> saveUser(String nombre, String email)  async{
        String url = '${enviroment.getUrl()}/user/createUser';

        final formData = FormData.fromMap(
          {'name': nombre,'email': email });

        final response = await Dio().post(url, data: formData);
        responseUser = ResponseData<User>.fromJson(
            response.data, (json) => User.fromJson(json));
        final User? mensaje = responseUser.data;
        return mensaje;
  }
}
