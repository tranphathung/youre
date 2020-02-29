import 'package:youre/models/channel_models.dart';

abstract class ChannelDetailEvent {}

class LoadChannelDetailVideos extends ChannelDetailEvent {
  Channel channel;
  LoadChannelDetailVideos({this.channel});
  @override
  String toString() {
    return "ChannelDetailEvent: LoadChannelDetailVideos";
  }
}

class LoadChannelDetailPlaylist extends ChannelDetailEvent {
  Channel channel;
  LoadChannelDetailPlaylist({this.channel});
  @override
  String toString() {
    return "ChannelDetailEvent: LoadChannelDetailPlaylist";
  }
}
