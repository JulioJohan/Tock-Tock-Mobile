import 'package:toktok/infrastructure/models/post_response.dart';
import 'package:toktok/infrastructure/models/response.dart';

abstract class PostRepository{

  Future<List<Post>> getAllPost();
  Future<Post> savePost();
}