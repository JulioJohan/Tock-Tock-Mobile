import 'package:flutter/material.dart';
import 'package:toktok/domain/entities/post_videos.dart';
import 'package:toktok/domain/repositories/video_post_repository.dart';

class DiscoverProvider extends ChangeNotifier {
  // TODO: Repository, DataSource
  final VideoPostRepository videosRepository;
  DiscoverProvider({required this.videosRepository});

  bool initialLoading = true;
  // Lista de Videos Post
  List<VideoPost> videos = [];

  Future<void> loadNextPage() async {
    // await Future.delayed(const Duration(seconds: 2));

    final newVideos = await videosRepository.getTrendigVideosByPage(1);

    // Agregamos la lista
    videos.addAll(newVideos);
    print(videos);
    initialLoading = false;
    // TODO: Cargar videos
    notifyListeners();
  }
}
