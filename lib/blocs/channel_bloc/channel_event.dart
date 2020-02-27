import 'package:youre/models/channel_models.dart';

abstract class ChannelEvent {}

class LoadListChannels extends ChannelEvent {
  final String accessToken;
  LoadListChannels({this.accessToken});
  @override
  String toString() {
    return "ChannelEvent: LoadListChannels";
  }
}

class LoadMoreChannels extends ChannelEvent {
  List<Channel> channels;
  String accessToken;
  LoadMoreChannels({this.channels, this.accessToken});
  @override
  String toString() {
    return "ChannelEvent: LoadMoreChannels";
  }
}

class PrepareLoadChannelDetail extends ChannelEvent {
  @override
  String toString() {
    return "ChannelState: PrepareChannelDetail";
  }
}

class LoadChannelDetail extends ChannelEvent {
  Channel channel;
  LoadChannelDetail({this.channel});
  @override
  String toString() {
    return "ChannelEvent: LoadChannelDetail";
  }
}
