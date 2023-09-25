import 'package:flutter/material.dart';
import 'package:toktok/domain/entities/post_videos.dart';
import 'package:toktok/infrastructure/models/local_video_model.dart';
import 'package:toktok/shared/data/local_video_posts.dart';

class DiscoverProvider extends ChangeNotifier {
  // TODO: Repository, DataSource

  bool initialLoading = true;
  // Lista de Videos Post
  List<VideoPost> videos = [];

  Future<void> loadNextPage() async {
    await Future.delayed(const Duration(seconds: 2));

    final List<VideoPost> newVideos = videoPosts
        //  Itera un sobre la lista
        .map((video) => LocalVideoModel
                // Resibe el map para transformarlos a JSON
                .fromJson(video)
            .toVideoPostEntity())
        // Lo convertimos a lista
        .toList();

    // Agregamos la lista
    videos.addAll(newVideos);
    print(videos);
    initialLoading = false;
    // TODO: Cargar videos
    notifyListeners();
  }
}
