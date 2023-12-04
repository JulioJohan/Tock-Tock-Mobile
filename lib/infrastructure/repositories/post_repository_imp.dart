import 'package:toktok/domain/datasources/post_datasource.dart';
import 'package:toktok/domain/repositories/post_repository.dart';
import 'package:toktok/infrastructure/models/post_response.dart';

class PostsRepositoryImpl implements PostRepository {
  final PostDataSource postDataSource;

  PostsRepositoryImpl(this.postDataSource);

  @override
  Future<List<Post>> getAllPost(int page, int size) {
    return postDataSource.getAllPost(page, size);
  }

  @override
  Future<Post> savePost() {
    // TODO: implement savePost
    throw UnimplementedError();
  }

  @override
  Future<Post> sumLike(int idPost) {
    return postDataSource.sumLike(idPost);
  }

  @override
  Future<Post> subtractLike(int idPost) {
    return postDataSource.subtractLike(idPost);
  }

    @override
  Future<List<Post>> findByUserPost(String type, String idUser) {
    return postDataSource.findByUserPost(type, idUser);
  }

    @override
  Future<String> deletePost(int idPost) {
    return postDataSource.deletePost(idPost);
  }
}
