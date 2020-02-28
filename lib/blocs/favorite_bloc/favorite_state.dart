import 'package:youre/models/video.dart';

abstract class FavoriteState {}

class FavoriteLoading extends FavoriteState {
  @override
  String toString() {
    return "FavoriteState: FavoriteLoding";
  }
}

class FavoriteLoaded extends FavoriteState {
  List<Video> videos;
  FavoriteLoaded({this.videos});
  @override
  String toString() {
    return "FavoriteState: FavoriteLoding";
  }
}
