import 'package:toktok/infrastructure/models/post_response.dart';

abstract class PostDataSource {
  Future<List<Post>> getAllPost(int page, int size);
  Future<Post> savePost();
}
