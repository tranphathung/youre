import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youre/models/channel_models.dart';

import '../blocs.dart';

class ChannelDetailBloc extends Bloc<ChannelDetailEvent, ChannelDetailState> {
  @override
  ChannelDetailState get initialState => ChannelDetailInit();

  @override
  Stream<ChannelDetailState> mapEventToState(ChannelDetailEvent event) async* {
    if (event is LoadChannelDetailVideos) {
      yield* _mapLoadChannelDetailVideosToState(event.channel);
    } else if (event is LoadChannelDetailPlaylists) {
      yield* _mapLoadChannelDetailPlaylistToState(event.channel);
    }
  }

  Stream<ChannelDetailState> _mapLoadChannelDetailVideosToState(
      Channel channel) async* {}

  Stream<ChannelDetailState> _mapLoadChannelDetailPlaylistToState(
      Channel channel) async* {}
}
