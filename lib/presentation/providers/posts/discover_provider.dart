import 'package:flutter/material.dart';
import 'package:toktok/domain/repositories/post_repository.dart';
import 'package:toktok/infrastructure/models/post_response.dart';

class DiscoverProvider extends ChangeNotifier {
  final PostRepository postRepository;
  DiscoverProvider({required this.postRepository});

  int page = 0;
  int size = 0;
  bool initialLoading = true;
  // Lista de Videos Post
  List<Post> videos = [];

  Future<void> loadNextPage() async {
    // await Future.delayed(const Duration(seconds: 2));
    page++;
    size++;
    final newVideos = await postRepository.getAllPost(page,size);

    // Agregamos la lista
    videos.addAll(newVideos);
    print(videos);
    initialLoading = false;
    // TODO: Cargar videos
    notifyListeners();
  }
}
