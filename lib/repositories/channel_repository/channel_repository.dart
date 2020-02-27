import 'package:youre/models/channel_models.dart';
import 'package:youre/services/api_services.dart';
import 'package:youre/utils/constants.dart';

class ChannelRepository {
  ChannelRepository._();
  static ChannelRepository channelRepository = ChannelRepository._();

  Future<List<Channel>> loadSubscriptionChannels(String accessToken) async {
    List<Channel> channels = await APIService.api_instance
        .fetchSubscriptionChannels(
            accessToken: accessToken,
            parts: [
              YoutubeVideoConstant.partSnippet,
              YoutubeVideoConstant.partContentDetails
            ],
            maxResults: '15',
            mine: true);
    return channels;
  }
}
