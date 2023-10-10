import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toktok/domain/datasources/post_datasource.dart';
import 'package:toktok/domain/repositories/post_repository.dart';
import 'package:toktok/infrastructure/datasources/post_datasource_imp.dart';
import 'package:toktok/infrastructure/models/post_response.dart';
import 'package:toktok/infrastructure/repositories/post_repository_imp.dart';
import 'package:toktok/presentation/providers/posts/post_repository_provider.dart';

final nowPlayingPostsProviderPage =
    StateNotifierProvider<PostsNotifier, List<Post>>((ref) {
  final fetchMorePosts = ref.watch(postRepositoryProvider).getAllPost;
  return PostsNotifier(postCallBack: fetchMorePosts);
});

final sumLikePostProvider = StateNotifierProvider<PostsNotifier2, Post>((ref) {
  PostDataSourceImpl postDataSource =
      PostDataSourceImpl(); // Initialize postDataSource
  final fetchMorePosts = PostsRepositoryImpl(postDataSource);
  return PostsNotifier2(postsRepository: fetchMorePosts);
});

final postDataSourceProvider = Provider<PostDataSource>((ref) {
  return PostDataSourceImpl();
});


typedef PostCallBack = Future<List<Post>> Function(int page, int size);

typedef PostCallBack2 = Future<List<Post>> Function(int idPost);

class PostsNotifier2 extends StateNotifier<Post> {
  final PostRepository postsRepository;

  PostsNotifier2({required this.postsRepository})
      : super(Post(
            idPost: 1,
            description: 'description',
            numLike: 1,
            multimedia: 'multimedia',
            share: '',
            type: 1));

  Future<Post> sumLike(int idPost) async {
    final postActualizado = await postsRepository.sumLike(idPost);
    return postActualizado;
  }
}

class PostsNotifier extends StateNotifier<List<Post>> {
  int page = 0;
  int size = 0;
  bool initialLoading = false;

  PostCallBack postCallBack;

  PostsNotifier({required this.postCallBack}) : super([]);

  Future<void> loadNextPage() async {
    if (initialLoading) return;
    initialLoading = true;
    page++;
    size++;
    final List<Post> posts = await postCallBack(0, 2);
    print(posts);
    state = [...state, ...posts];
    initialLoading = false;
  }
}
