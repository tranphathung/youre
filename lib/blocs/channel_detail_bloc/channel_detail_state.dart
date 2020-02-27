import 'package:youre/models/playlist.dart';
import 'package:youre/models/video.dart';

abstract class ChannelDetailState {}

class ChannelDetailInit extends ChannelDetailState {
  @override
  String toString() {
    return "ChannelDetailState: ChannelDetailInit";
  }
}

class ChannelDetailVideoLoaded extends ChannelDetailState {
  List<Video> videos;
  ChannelDetailVideoLoaded({this.videos});
  @override
  String toString() {
    return "ChannelDetail: ChannelDetailVideoLoaded";
  }
}

class ChannelDetailPlaylistLoading extends ChannelDetailState {
  @override
  String toString() {
    return "ChannelDetail: PlaylistLoading";
  }
}

class ChannelDetailPlaylistLoaded extends ChannelDetailState {
  List<Playlist> playist;
  ChannelDetailPlaylistLoaded({this.playist});
  @override
  String toString() {
    return "ChannelDetail: PlaylistLoaded";
  }
}
