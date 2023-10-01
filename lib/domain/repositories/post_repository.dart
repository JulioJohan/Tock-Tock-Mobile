import 'package:toktok/infrastructure/models/post_response.dart';

abstract class PostRepository{

  Future<List<Post>> getAllPost(int page,int size);
  Future<Post> savePost();
}