import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youre/blocs/blocs.dart';
import 'package:youre/models/channel_models.dart';
import 'package:youre/repositories/channel_repository/channel_repository.dart';

class ChannelBloc extends Bloc<ChannelEvent, ChannelState> {
  final LoginBloc loginBloc;
  ChannelBloc({this.loginBloc}) {
    loginBloc.listen((state) {
      if (state is Authenticated) {
        this.add(LoadListChannels(accessToken: state.user.accessToken));
      }
    });
  }
  @override
  ChannelState get initialState => ChannelListLoading();

  @override
  Stream<ChannelState> mapEventToState(ChannelEvent event) async* {
    if (event is LoadListChannels) {
      yield* _mapLoadListChannelToState(event.accessToken);
    } else if (event is LoadMoreChannels) {
      yield* _mapLoadMoreChannelsToState(event.channels, event.accessToken);
    } else if (event is PrepareLoadChannelDetail) {
      yield ChannelDetailLoading();
    } else if (event is LoadChannelDetail) {
      yield* _mapLoadChannelDetailToState(event.channel);
    }
  }

  Stream<ChannelState> _mapLoadListChannelToState(String accessToken) async* {
    List<Channel> channels = await ChannelRepository.channelRepository
        .loadSubscriptionChannels(accessToken);
    yield ChannelListLoaded(channels: channels);
  }

  Stream<ChannelState> _mapLoadMoreChannelsToState(
      List<Channel> channels, String accessToken) async* {
    List<Channel> moreChannels = await ChannelRepository.channelRepository
        .loadSubscriptionChannels(accessToken);
    channels.addAll(moreChannels);
    yield ChannelListLoaded(channels: channels);
  }

  Stream<ChannelState> _mapLoadChannelDetailToState(Channel channel) async* {
    yield ChannelDetailLoaded(videos: [], playlists: [], channel: channel);
  }
}
