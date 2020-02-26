import 'package:youre/models/video.dart';

abstract class PopularEvent {}

class LoadPopular extends PopularEvent {
  @override
  String toString() {
    return "PopularEvent: LoadPopular";
  }
}

class UpdatePopular extends PopularEvent {
  List<Video> videos;
  UpdatePopular(this.videos);
  @override
  String toString() {
    return "PopularEvent: UpdatePopular";
  }
}