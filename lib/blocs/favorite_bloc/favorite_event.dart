import 'package:youre/models/video.dart';

abstract class FavoriteEvent {}

class LoadFavorite extends FavoriteEvent {
  final String accessToken;
  LoadFavorite({this.accessToken});
  @override
  String toString() {
    return "FavoriteEvent: LoadFavorite";
  }
}

class UpdateFavorite extends FavoriteEvent {
  final String accessToken;
  final List<Video> videos;
  UpdateFavorite({this.accessToken, this.videos});
  @override
  String toString() {
    return "FavoriteEvent: UpdateFavorite";
  }
}
