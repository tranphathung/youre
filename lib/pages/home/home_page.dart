import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:youre/blocs/popular_bloc/popular_bloc.dart';
import 'package:youre/blocs/popular_bloc/popular_events.dart';
import 'package:youre/blocs/popular_bloc/popular_state.dart';
import 'package:youre/models/user_model.dart';
import 'package:youre/models/video.dart';
import 'package:youre/pages/video/video_page.dart';
import 'package:youre/repositories/repositories.dart';
import 'package:youre/utils/constants.dart';
import 'package:youre/widgets/bottom_navy_bar.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage(this.user);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double currentPageValue = 0;
  PageController _pageController;
  ScrollController _customeScrollController;
  List<Video> _videos;
  PopularBloc _popBloc;

  @override
  void initState() {
    _videos = List();
    _pageController = PageController(initialPage: 0);
    _customeScrollController = ScrollController();
    _customeScrollController.addListener(() async {
      if (_customeScrollController.position.pixels ==
          _customeScrollController.position.maxScrollExtent) {
        await _fetchMorePopularVideos();
      }
    });
  }

  @override
  void dispose() {
    _customeScrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _popBloc = BlocProvider.of<PopularBloc>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            children: <Widget>[
              BlocBuilder<PopularBloc, PopularState>(
                builder: (context, state) {
                  if (state is PopularLoaded) {
                    List<Video> videos = state.videos;
                    _videos = videos;
                    return Container(
                        color: primaryColor,
                        child: ListView.builder(
                          controller: _customeScrollController,
                          itemCount: _videos.length,
                          itemBuilder: (context, index) {
                            Video video = _videos[index];
                            return _buildVideo(video);
                          },
                        ) /* ListWheelScrollView(
                                controller: _customeScrollController,
                                children:
                                    _videos.map((video) => _buildVideo(video)).toList(),
                                itemExtent: 280.0,
                                diameterRatio: 4.5,
                              ),*/
                        );
                  } else {
                    return Container(
                      color: primaryColor,
                      child: Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              Container(
                color: primaryColor,
                child: Center(
                  child: Text("page 2"),
                ),
              ),
              Container(
                color: primaryColor,
                child: Center(
                  child: Text("page 3"),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
          selectedIndex: currentPageValue.toInt(),
          animationDuration: Duration(milliseconds: 300),
          curve: Curves.easeInQuad,
          backgroundColor: secondaryColor,
          showElevation: true,
          items: [
            BottomNavyBarItem(
                icon: Icon(LineIcons.home),
                title: Text("Popular"),
                activeColor: primaryColor.withAlpha(50)),
            BottomNavyBarItem(
                icon: Icon(Icons.favorite_border),
                title: Text("Like"),
                activeColor: primaryColor.withAlpha(50)),
            BottomNavyBarItem(
                icon: Icon(Icons.people_outline),
                title: Text("Channel"),
                activeColor: primaryColor.withAlpha(50)),
          ],
          onItemSelected: (index) {
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInCirc);
            setState(() {
              currentPageValue = index.toDouble();
            });
          }),
    );
  }

  Widget _buildVideo(Video video) {
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
            decoration: BoxDecoration(color: primaryColor.withAlpha(150)),
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
            top: 20.0,
            child: Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            LineIcons.eye,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            video.viewCount,
                            style: defaultTextStyle.copyWith(fontSize: 12.0),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            LineIcons.thumbs_o_up,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            video.viewCount,
                            style: defaultTextStyle.copyWith(fontSize: 12.0),
                          )
                        ],
                      ),
                    )
                  ],
                ),
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

  Future _fetchMorePopularVideos() async {
    _popBloc.add(UpdatePopular(_videos));
  }
}
