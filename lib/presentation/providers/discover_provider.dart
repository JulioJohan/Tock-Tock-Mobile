import 'package:flutter/material.dart';
import 'package:toktok/domain/entities/post_videos.dart';

class DiscoverProvider extends ChangeNotifier {
  bool initialLoading = true;
  // Lista de Videos Post
  List<VideoPost> videoPost = [];

  Future<void> loadNextPage() async {
    // TODO: Cargar videos
    notifyListeners();
  }
}
