import 'package:line_icons/line_icons.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:youre/models/video.dart';
import 'package:youre/utils/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  final Video video;
  VideoPage({@required this.video}) : assert(video != null);
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  YoutubePlayerController _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    _youtubePlayerController = YoutubePlayerController(
        initialVideoId: widget.video.id,
        flags: YoutubePlayerFlags(mute: false, autoPlay: false));
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SwipeDetector(
      onSwipeRight: () {
        Navigator.pop(context);
      },
      child: Container(
        color: primaryColor,
        child: Column(
          children: <Widget>[
            Container(
                child: YoutubePlayer(
              controller: _youtubePlayerController,
              showVideoProgressIndicator: true,
              onReady: () {
                print("Video ready!");
              },
            )),
            Padding(
              padding: defaultPadding,
              child: Text(
                widget.video.title,
                style: defaultTextStyle.copyWith(
                    fontWeight: FontWeight.w700, height: 1.5),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
