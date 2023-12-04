import 'dart:io';

import 'package:dio/dio.dart';
import 'package:toktok/config/enviroments/enviroments.dart';
import 'package:toktok/domain/datasources/post_datasource.dart';
import 'package:toktok/infrastructure/models/post_dto.response.dart';
import 'package:toktok/infrastructure/models/post_response.dart';
import 'package:toktok/infrastructure/models/response.dart';

class PostDataSourceImpl implements PostDataSource {
  final enviroment = Enviroment();
  ResponseData<Post> responsePost =
      ResponseData(status: "", message: "", list: [], count: 0);

  @override
  Future<List<Post>> getAllPost(int page, int size) async {
    String url = '${enviroment.getUrl()}/post/findAllPost';
    print(url);
    final response = await Dio().get(url);
    // print(response.data['list']);
    responsePost = ResponseData<Post>.fromJson(
        response.data, (json) => Post.fromJson(json));
    final List<Post> listPost = responsePost.list!.cast<Post>();
    print(listPost);
    return listPost;
  }

  @override
  Future<Post> savePost(PostDto post, String urlPost) async {
    ResponseData<Post> responsePost =
        ResponseData(status: "", message: "", count: 0);

    // Crear un MultipartFile
    final videoFile = await MultipartFile.fromFile(urlPost, filename: 'video.mp4');

    final formData = FormData.fromMap(
      {'description': post.description, 'multipartFile': videoFile, 'user':2});
    
    String url = '${enviroment.getUrl()}/post/createPost/0';
    final response = await Dio().post(url, data: formData);
    responsePost = ResponseData<Post>.fromJson(
        response.data, (json) => Post.fromJson(json));
    final Post postRespuesta = responsePost.data!;
    return postRespuesta;
  }

  @override
  Future<Post> sumLike(int idPost) async {
    ResponseData<Post> responsePostSum =
        ResponseData(status: "", message: "", list: [], count: 0);
    String url = '${enviroment.getUrl()}/post/sumLike/$idPost';
    final response = await Dio().put(url);
    responsePostSum = ResponseData<Post>.fromJson(
        response.data, (json) => Post.fromJson(json));
    final Post post = responsePostSum.data!;
    return post;
  }

  @override
  Future<Post> subtractLike(int idPost) async {
    ResponseData<Post> responsePostSum =
        ResponseData(status: "", message: "", list: [], count: 0);
    String url = '${enviroment.getUrl()}/post/subtractLike/$idPost';
    final response = await Dio().put(url);
    responsePostSum = ResponseData<Post>.fromJson(
        response.data, (json) => Post.fromJson(json));
    final Post post = responsePostSum.data!;
    return post;
  }

    @override
  Future<List<Post>> findByUserPost(String idUser, String type) async {

    String url = '${enviroment.getUrl()}/post/findByUserPost/${idUser}/${type}';
    print(url);
    final response = await Dio().get(url);
    // print(response.data['list']);
    responsePost = ResponseData<Post>.fromJson(
        response.data, (json) => Post.fromJson(json));
    final List<Post> listPost = responsePost.list!.cast<Post>();
    print(listPost);
    return listPost;
  }

    @override
  Future<String> deletePost(int idPost) async {

    String url = '${enviroment.getUrl()}/post/deletePost/$idPost';
    final response = await Dio().delete(url);
    responsePost = ResponseData<Post>.fromJson(
        response.data, (json) => Post.fromJson(json));
    final String mensaje = responsePost.message;
    return mensaje;
  }

    @override
  Future<String> updatePost(int tipo, Post post) async {
        String url = '${enviroment.getUrl()}/post/updatePost/$tipo';

    final formData = FormData.fromMap(
      {'idPost':post.idPost,'description': post.description });

    final response = await Dio().put(url, data: formData);
    responsePost = ResponseData<Post>.fromJson(
        response.data, (json) => Post.fromJson(json));
    final String mensaje = responsePost.message;
    return mensaje;
  }
}
