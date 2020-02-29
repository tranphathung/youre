import 'package:youre/models/video.dart';
import 'package:youre/services/api_channel_detail.dart';

class ChannelDetailRepository {
  ChannelDetailRepository._();
  static ChannelDetailRepository _channelDetailRepository;
  static ChannelDetailRepository getInstance() {
    if (_channelDetailRepository == null) {
      _channelDetailRepository = ChannelDetailRepository._();
      return _channelDetailRepository;
    }
    return _channelDetailRepository;
  }

  Future<List<Video>> loadChannelDetailVideos(String channelId) async {
    List<Video> videos =
        await ApiChannelDetail.getInstance().getChannelDetailVideos(channelId);
    return videos;
  }
}
