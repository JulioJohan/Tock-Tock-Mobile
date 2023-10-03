import 'package:toktok/infrastructure/models/post_response.dart';

abstract class PostRepository{
  Future<Post> subtractLike(int idPost);
  Future<Post> sumLike(int idPost);
  Future<List<Post>> getAllPost(int page,int size);
  Future<Post> savePost();
}