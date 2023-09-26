import 'package:toktok/domain/datasources/video_post_datasourse.dart';
import 'package:toktok/domain/entities/post_videos.dart';
import 'package:toktok/infrastructure/models/local_video_model.dart';
import 'package:toktok/shared/data/local_video_posts.dart';

// La implementacion de los videos locales
class LocalVideoDataSourceImpl implements VideoPostDataSource {
  @override
  Future<List<VideoPost>> getFavoritesVideosByUser(String userId) {
    // TODO: implement getFavoritesVideosByUser
    throw UnimplementedError();
  }

  @override
  Future<List<VideoPost>> getTrendigVideosByPage(int page) async {
    await Future.delayed(const Duration(seconds: 2));

    // await Future.delayed(const Duration(seconds: 2));

    final List<VideoPost> newVideos = videoPosts
        //  Itera un sobre la lista
        .map((video) => LocalVideoModel
                // Resibe el map para transformarlos a JSON
                .fromJson(video)
            .toVideoPostEntity())
        // Lo convertimos a lista
        .toList(); 
    return newVideos;
  }
}
