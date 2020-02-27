import 'package:youre/models/video.dart';

class Playlist {
  final String id;
  final String channelId;
  final String title;
  final List<Video> videos;

  Playlist({this.id, this.channelId, this.title, this.videos});
}
