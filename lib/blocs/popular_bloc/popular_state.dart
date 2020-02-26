import 'package:youre/models/video.dart';

abstract class PopularState {}

class PopularLoading extends PopularState {
  @override
  String toString() {
    return "PopularState: PopularLoading";
  }
}

class PopularLoaded extends PopularState {
  final List<Video> videos;
  PopularLoaded({this.videos});

  @override
  String toString() {
    return "PopularState: PopularLoaded";
  }
}

class PopularUpdating extends PopularState {
  final List<Video> videos;
  final String itemCounts;
  final String nextPageToken;
  PopularUpdating({this.videos, this.itemCounts, this.nextPageToken});

  @override
  String toString() {
    return "PopularState: PopularUpdating";
  }
}
