import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:youre/blocs/blocs.dart';
import 'package:youre/models/channel_models.dart';
import 'package:youre/models/video.dart';
import 'package:youre/pages/video/video_page.dart';
import 'package:youre/utils/constants.dart';
import 'package:youre/widgets/bottom_navy_bar.dart';

class ChannelDetail extends StatefulWidget {
  final Channel channel;
  ChannelDetail({this.channel});
  @override
  _ChannelDetailState createState() => _ChannelDetailState();
}

class _ChannelDetailState extends State<ChannelDetail> {
  int currentPageValue;
  PageController _pageController;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    currentPageValue = 0;
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChannelDetailBloc>(
      create: (context) => ChannelDetailBloc()
        ..add(LoadChannelDetailVideos(channel: widget.channel)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            currentPageValue == 0 ? "Videos" : "Playlist",
            style: defaultTextStyle,
          ),
          backgroundColor: secondaryColor,
          leading: IconButton(
            icon: Icon(LineIcons.arrow_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: PageView(
          children: <Widget>[
            BlocBuilder<ChannelDetailBloc, ChannelDetailState>(
              builder: (context, state) {
                if (state is ChannelDetailVideosLoaded) {
                  List<Video> videos = state.videos;
                  return Container(
                    color: primaryColor,
                    child: ListView.builder(
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        Video video = videos[index];
                        return _builtVideo(video);
                      },
                    ),
                  );
                } else {
                  return Container(
                    color: primaryColor,
                    child: Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      ),
                    ),
                  );
                }
              },
            )
          ],
        ),
        bottomNavigationBar: BottomNavyBar(
            selectedIndex: currentPageValue,
            animationDuration: Duration(milliseconds: 300),
            curve: Curves.easeInQuad,
            backgroundColor: secondaryColor,
            showElevation: true,
            items: [
              BottomNavyBarItem(
                  icon: Icon(
                    Icons.video_library,
                    color: Colors.white,
                  ),
                  title: Text("Videos"),
                  activeColor: primaryColor.withAlpha(50)),
              BottomNavyBarItem(
                  icon: Icon(Icons.playlist_play),
                  title: Text("Playlist"),
                  activeColor: primaryColor.withAlpha(50)),
            ],
            onItemSelected: (index) async {
              if (_pageController.hasClients) {
                await _pageController.animateToPage(index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInCirc);
              }
              setState(() {
                currentPageValue = index;
              });
            }),
      ),
    );
  }

  Widget _builtVideo(Video video) {
    return Container(
      height: 180.0,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 25.0),
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
              child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Container(
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(video.thumbnailURL),
              ),
            ),
          )),
          Positioned.fill(
              child: Container(
            decoration: BoxDecoration(color: primaryColor.withAlpha(120)),
          )),
          Positioned(
            bottom: 10.0,
            left: 10.0,
            child: SizedBox(
              width: 275.0,
              child: Text(
                video.title,
                style: defaultTextStyle.copyWith(fontSize: 16.0),
              ),
            ),
          ),
          Positioned.fill(
              child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: secondaryColor.withAlpha(90),
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (context, ani1, ani2) => VideoPage(
                              video: video,
                            ),
                        transitionDuration: Duration(milliseconds: 300),
                        transitionsBuilder: (context, ani1, ani2, child) {
                          return FadeTransition(
                            opacity: ani1,
                            child: child,
                          );
                        }));
              },
            ),
          ))
        ],
      ),
    );
  }
}
