import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toktok/infrastructure/models/post_response.dart';
import 'package:toktok/presentation/providers/posts/post_repository_provider.dart';

final nowPlayingPostsProvider = StateNotifierProvider<PostsNotifier,List<Post>>((ref){

  final fetchMorePosts = ref.watch(postRepositoryProvider).getAllPost;
  return PostsNotifier(
    postCallBack:fetchMorePosts
  );
});


typedef PostCallBack = Future<List<Post>> Function(int page, int size);

class PostsNotifier extends StateNotifier<List<Post>> {
  int page = 0;
  int size = 0;
  bool initialLoading = true;

  PostCallBack postCallBack;

  PostsNotifier({required this.postCallBack}) : super([]);

  Future<void> loadNextPage() async {
    if ( initialLoading ) return;
    initialLoading = true;
    page++;
    size++;
    final List<Post> posts = await postCallBack(page, size);
    state = [...state,...posts];
    initialLoading = false;
  }
}
