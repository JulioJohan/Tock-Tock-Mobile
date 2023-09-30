import 'package:toktok/infrastructure/models/post_response.dart';
import 'package:toktok/infrastructure/models/response.dart';

abstract class PostDataSource {
  Future<List<Post>> getAllPost();
  Future<Post> savePost();
}
