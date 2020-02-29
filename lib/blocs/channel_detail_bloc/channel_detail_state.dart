import 'package:youre/models/video.dart';

abstract class ChannelDetailState {}

class ChannelDetaiVideoslLoading extends ChannelDetailState {
  @override
  String toString() {
    return "ChannelDetailState: ChannelDetailLoading";
  }
}

class ChannelDetailVideosLoaded extends ChannelDetailState {
  List<Video> videos;
  ChannelDetailVideosLoaded({this.videos});
  @override
  String toString() {
    return "ChannelDetailState: ChannelDetailLoaded";
  }
}
