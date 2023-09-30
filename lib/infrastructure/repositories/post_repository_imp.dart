import 'package:toktok/domain/datasources/post_datasource.dart';
import 'package:toktok/domain/repositories/post_repository.dart';
import 'package:toktok/infrastructure/models/post_response.dart';

class PostsRepositoryImpl implements PostRepository {
  final PostDataSource postDataSource;

  PostsRepositoryImpl({required this.postDataSource});

  @override
  Future<List<Post>> getAllPost() {
    return postDataSource.getAllPost();
  }

  @override
  Future<Post> savePost() {
    // TODO: implement savePost
    throw UnimplementedError();
  }
}
