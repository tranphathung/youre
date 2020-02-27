abstract class ChannelEvent {}

class LoadListChannels extends ChannelEvent {
  final String accessToken;
  LoadListChannels({this.accessToken});
  @override
  String toString() {
    return "ChannelEvent: LoadListChannels";
  }
}
