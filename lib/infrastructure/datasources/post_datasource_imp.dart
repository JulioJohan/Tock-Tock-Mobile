import 'package:dio/dio.dart';
import 'package:toktok/config/enviroments/enviroments.dart';
import 'package:toktok/domain/datasources/post_datasource.dart';
import 'package:toktok/infrastructure/models/post_response.dart';
import 'package:toktok/infrastructure/models/response.dart';

class PostDataSourceImpl implements PostDataSource {
  final enviroment = Enviroment();
  ResponseData<Post> responsePost =
      ResponseData(status: "", message: "", list: [], count: 0);

  @override
  Future<List<Post>> getAllPost(int page, int size) async {
    String url = '${enviroment.getUrl()}/post/findAllPost/$page/$size ';
    // print(url);
    final response = await Dio().get(url);
    // print(response.data['list']);
    responsePost =  ResponseData<Post>.fromJson(
        response.data, (json) => Post.fromJson(json));
    final List<Post> listPost = responsePost.list!.cast<Post>();
    return listPost;
  }

  @override
  Future<Post> savePost() {
    // TODO: implement savePost
    throw UnimplementedError();
  }
}
