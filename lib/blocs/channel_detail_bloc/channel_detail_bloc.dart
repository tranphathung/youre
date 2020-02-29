import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youre/blocs/channel_detail_bloc/channel_detail_event.dart';
import 'package:youre/blocs/channel_detail_bloc/channel_detail_state.dart';
import 'package:youre/models/channel_models.dart';
import 'package:youre/models/video.dart';
import 'package:youre/repositories/repositories.dart';

class ChannelDetailBloc extends Bloc<ChannelDetailEvent, ChannelDetailState> {
  @override
  ChannelDetailState get initialState => ChannelDetaiVideoslLoading();

  @override
  Stream<ChannelDetailState> mapEventToState(ChannelDetailEvent event) async* {
    if (event is LoadChannelDetailVideos) {
      yield* _mapLoadChannelDetailVideosToState(event.channel);
    }
  }

  Stream<ChannelDetailState> _mapLoadChannelDetailVideosToState(
      Channel channel) async* {
    List<Video> videos = await ChannelDetailRepository.getInstance()
        .loadChannelDetailVideos(channel.id);
    yield ChannelDetailVideosLoaded(videos: videos);
  }
}
