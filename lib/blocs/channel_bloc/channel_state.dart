import 'package:youre/models/channel_models.dart';

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
