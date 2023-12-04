import 'package:toktok/infrastructure/models/post_dto.response.dart';
import 'package:toktok/infrastructure/models/post_response.dart';

abstract class PostDataSource {
  Future<Post> subtractLike(int idPost);
  Future<Post> sumLike(int idPost);
  Future<List<Post>> getAllPost(int page, int size);
  Future<Post> savePost(PostDto post, String urlVideo);
  Future<List<Post>> findByUserPost(String idUser, String type);
  Future<String> deletePost(int idPost);
  Future<String> updatePost(int tipo, Post post);
}
