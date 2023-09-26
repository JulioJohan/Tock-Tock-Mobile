import 'package:toktok/domain/entities/post_videos.dart';

abstract class VideoPostRepository {

  Future<List<VideoPost>> getFavoritesVideosByUser(String userId);
  Future<List<VideoPost>> getTrendigVideosByPage(int page);

}
