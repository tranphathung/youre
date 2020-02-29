class Video {
  final String id;
  final String title;
  final String thumbnailURL;
  final String channelTitle;
  final String viewCount;
  final String likeCount;

  Video(
      {this.id,
      this.title,
      this.thumbnailURL,
      this.channelTitle,
      this.viewCount,
      this.likeCount});

  factory Video.fromMapPopular(Map<String, dynamic> json) {
    return Video(
        id: json['id'],
        title: json['snippet']['title'],
        thumbnailURL: json['snippet']['thumbnails']['high']['url'],
        channelTitle: json['channelTitle'],
        viewCount: json['statistics']['viewCount'],
        likeCount: json['statistics']['likeCount']);
  }

  factory Video.fromPlaylistItem(Map<String, dynamic> json){
    return Video(
      id: json['contentDetails']['videoId'],
      title: json['snippet']['title'],
      thumbnailURL: json['snippet']['thumbnails']['high']['url'],
      channelTitle: json['snippet']['channelTittle']
    );
  }
  @override
  String toString() {
    return "Video $id";
  }
}
