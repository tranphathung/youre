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

class LoadUpdateListChannel extends ChannelEvent {
  List<Channel> channels;
  String accessToken;
  LoadUpdateListChannel({this.channels, this.accessToken});
  @override
  String toString() {
    return "ChannelEvent: LoadUpdateListChannel";
  }
}
