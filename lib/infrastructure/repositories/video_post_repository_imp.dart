import 'package:toktok/domain/datasources/video_post_datasourse.dart';
import 'package:toktok/domain/entities/post_videos.dart';
import 'package:toktok/domain/repositories/video_post_repository.dart';

class VideoPostsRepositoryImpl implements VideoPostRepository {
  final VideoPostDataSource videosDataSource;

  VideoPostsRepositoryImpl({required this.videosDataSource});

  @override
  Future<List<VideoPost>> getFavoritesVideosByUser(String userId) {
    // TODO: implement getFavoritesVideosByUser
    throw UnimplementedError();
  }

  @override
  Future<List<VideoPost>> getTrendigVideosByPage(int page) {
    return videosDataSource.getTrendigVideosByPage(page);
  }
}
