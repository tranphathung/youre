import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  final String id;
  VideoPage({@required this.id}) : assert(id != null);
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  YoutubePlayerController _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    _youtubePlayerController = YoutubePlayerController(
        initialVideoId: widget.id,
        flags: YoutubePlayerFlags(mute: false, autoPlay: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: YoutubePlayer(
        controller: _youtubePlayerController,
        showVideoProgressIndicator: true,
        onReady: () {
          print("Video ready!");
        },
      ),
    );
  }
}
