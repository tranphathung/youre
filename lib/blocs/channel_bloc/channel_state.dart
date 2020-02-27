import 'package:youre/models/channel_models.dart';
import 'package:youre/models/playlist.dart';
import 'package:youre/models/video.dart';

abstract class ChannelState {}

class ChannelListLoading extends ChannelState {
  @override
  String toString() {
    return "ChannelState: ChannelListLoading";
  }
}

class ChannelListLoaded extends ChannelState {
  final List<Channel> channels;
  ChannelListLoaded({this.channels});
  @override
  String toString() {
    return "ChannelState: ChannelListLoaded";
  }
}

class ChannelDetailLoading extends ChannelState {
  @override
  String toString() {
    return "ChannelState: ChannelDetailLoading";
  }
}

class ChannelDetailLoaded extends ChannelState {
  List<Video> videos;
  List<Playlist> playlists;
  Channel channel;
  ChannelDetailLoaded({this.videos, this.playlists, this.channel});
  @override
  String toString() {
    return "ChannelState: ChannelDetailLoaded";
  }
}
