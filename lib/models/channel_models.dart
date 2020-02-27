import 'video.dart';

class Channel {
  final String title;
  final String id;
  final String description;
  final String thumbnailUrl;
  final String totalItemCount;
  List<Video> videos;

  Channel(
      {this.id,
      this.title,
      this.description,
      this.thumbnailUrl,
      this.videos,
      this.totalItemCount}) {
    this.videos = List();
  }

  factory Channel.fromSubscription(Map<String, dynamic> json) {
    return Channel(
        id: json['snippet']['resourceId']['channelId'],
        title: json['snippet']['title'],
        description: json['snippet']['description'],
        thumbnailUrl: json['snippet']['thumbnails']['high']['url'],
        totalItemCount: json['contentDetails']['totalItemCount']);
  }

  @override
  String toString() {
    return "Channel: {$id: $title}";
  }
}
