import 'package:flutter/material.dart';
import 'package:youre/models/channel_models.dart';
import 'package:youre/models/video_channel.dart';
import 'package:youre/pages/video_page/video_page.dart';
import 'package:youre/services/api_services.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  Channel _channel;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bao Binh Tarot")),
      body: FutureBuilder(
        future: APIService.api_instance
            .fetchChannel(channelId: 'UCgv7drSmFw3O9HnL4ZJ6mVw'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null)
            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            );
          _channel = snapshot.data;
          return NotificationListener(
            onNotification: (ScrollNotification scrollNotification) {
              if (!_isLoading &&
                  _channel.videoCount.length !=
                      int.parse(_channel.videoCount) &&
                  scrollNotification.metrics.pixels ==
                      scrollNotification.metrics.maxScrollExtent)
                _loadMoreVideos();
            },
            child: ListView.builder(
              itemCount: _channel.videos.length,
              itemBuilder: (context, index) {
                Video video = _channel.videos[index];
                return _buildVideo(video);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildVideo(Video video) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoPage(
                      id: video.id,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        height: 140.0,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black12, offset: Offset(0, 1), blurRadius: 6.0)
        ]),
        child: Row(
          children: <Widget>[
            Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailURL),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                video.title,
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.api_instance
        .fetchVideosFromPlaylist(playlistId: _channel.uploadPlaylistID);
    List<Video> allVideos = _channel.videos..addAll(moreVideos);
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = false;
  }
}
