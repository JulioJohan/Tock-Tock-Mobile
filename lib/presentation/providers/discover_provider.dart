import 'package:flutter/material.dart';
import 'package:toktok/domain/entities/post_videos.dart';
import 'package:toktok/domain/repositories/post_repository.dart';
import 'package:toktok/domain/repositories/video_post_repository.dart';
import 'package:toktok/infrastructure/models/post_response.dart';

class DiscoverProvider extends ChangeNotifier {
  // TODO: Repository, DataSource
  final PostRepository postRepository;
  DiscoverProvider({required this.postRepository});

  bool initialLoading = true;
  // Lista de Videos Post
  List<Post> videos = [];

  Future<void> loadNextPage() async {
    // await Future.delayed(const Duration(seconds: 2));

    final newVideos = await postRepository.getAllPost();

    // Agregamos la lista
    videos.addAll(newVideos);
    print(videos);
    initialLoading = false;
    // TODO: Cargar videos
    notifyListeners();
  }
}
