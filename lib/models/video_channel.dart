class Video {
  final String id;
  final String title;
  final String thumbnailURL;
  final String channelTitle;

  Video({this.id, this.title, this.thumbnailURL, this.channelTitle});

  factory Video.fromMap(Map<String, dynamic> snippet) {
    return Video(
        id: snippet['resourceId']['videoId'],
        title: snippet['title'],
        thumbnailURL: snippet['thumbnails']['high']['url'],
        channelTitle: snippet['channelTitle']);
  }
}
