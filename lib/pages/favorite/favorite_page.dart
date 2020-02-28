import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:youre/blocs/blocs.dart';
import 'package:youre/models/video.dart';
import 'package:youre/pages/video/video_page.dart';
import 'package:youre/utils/constants.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  double currentPageValue = 2;
  ScrollController _customeScrollController;
  List<Video> _videos;
  FavoriteBloc _favoriteBloc;
  LoginBloc _loginBloc;

  @override
  void initState() {
    _videos = List();
    _customeScrollController = ScrollController();
    _customeScrollController.addListener(() {
      if (_customeScrollController.position.pixels ==
          _customeScrollController.position.maxScrollExtent) {
        _fetchMoreFavoriteVideos();
      }
    });
  }

  @override
  void dispose() {
    _customeScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoaded) {
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
                ));
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
      ),
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

  _fetchMoreFavoriteVideos() async {
    if (_loginBloc.state is Authenticated) {
      _favoriteBloc.add(UpdateFavorite(
          accessToken: (_loginBloc.state as Authenticated).user.accessToken,
          videos: _videos));
    }
  }
}
