import 'package:youre/models/video.dart';

class FavoriteRepository {
  FavoriteRepository._();
  static FavoriteRepository _favoriteRepository;
  static FavoriteRepository getInstance() {
    if (_favoriteRepository == null) {
      _favoriteRepository = FavoriteRepository._();
      return _favoriteRepository;
    }
    return _favoriteRepository;
  }

  Future<List<Video>> loadFavoriteVideos(String accessToken) async {
    return [];
  }
}
