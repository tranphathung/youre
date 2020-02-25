import 'video_channel.dart';

class Channel{
  final String id;
  final String title;
  final String projilePictureURL;
  final String subscriberCount;
  final String videoCount;
  final String uploadPlaylistID;
  List<Video> videos;

  Channel({
    this.id,
    this.title,
    this.projilePictureURL,
    this.subscriberCount,
    this.uploadPlaylistID,
    this.videoCount,
    this.videos
  });

  factory Channel.fromMap(Map<String, dynamic> map){
    return Channel(
      id: map['id'],
      title: map['snippet']['title'],
      projilePictureURL: map['snippet']['thumbnails']['default']['url'],
      subscriberCount: map['statistics']['subscriberCount'],
      videoCount: map['statistics']['videoCount'],
      uploadPlaylistID: map['contentDetails']['relatedPlaylists']['uploads']
    );
  }
}