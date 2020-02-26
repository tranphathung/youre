import 'package:youre/models/video.dart';
import 'package:youre/services/api_services.dart';
import 'package:youre/utils/constants.dart';

class VideoRepository {
  VideoRepository._();
  static final VideoRepository videoRepository = VideoRepository._();

  Future<List<Video>> loadPopularVideos() async {
    List<Video> popularVideos =
        await APIService.api_instance.fetchPopularVideos(
            chart: YoutubeVideoConstant.chartMostPopular,
            parts: [
              YoutubeVideoConstant.partSnippet,
              YoutubeVideoConstant.partContentDetails,
              YoutubeVideoConstant.partStatistics
            ],
            regionCode: 'VN');
    return popularVideos;
  }
}
