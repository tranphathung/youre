import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youre/blocs/blocs.dart';
import 'package:youre/models/channel_models.dart';
import 'package:youre/pages/channel/channel_detail.dart';
import 'package:youre/utils/constants.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({Key key}) : super(key: key);

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  ScrollController _scrollController;
  ChannelBloc _channelBloc;
  List<Channel> _channels;
  LoginBloc _loginBloc;

  @override
  void initState() {
    _scrollController = ScrollController(initialScrollOffset: 0);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreChannel();
      }
    });
    _channels = List();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _channelBloc = BlocProvider.of<ChannelBloc>(context);
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    return BlocBuilder<ChannelBloc, ChannelState>(
      builder: (context, state) {
        if (state is ChannelListLoaded) {
          _channels = state.channels;
          return Container(
            color: primaryColor,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _channels.length,
              itemBuilder: (context, index) {
                Channel channel = _channels[index];
                return _buildChannel(channel, context);
              },
            ),
          );
        } else {
          return Container(
            color: primaryColor,
            child: Center(
              child: Text(
                "loading...........",
                style: defaultTextStyle,
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildChannel(Channel channel, BuildContext context) {
    return Container(
      height: 180.0,
      margin: EdgeInsets.only(bottom: 25.0),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
                child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Container(
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(channel.thumbnailUrl),
                ),
              ),
            )),
            Positioned.fill(
                child: Container(
              color: primaryColor.withOpacity(0.35),
            )),
            Positioned(
              bottom: 10.0,
              left: (MediaQuery.of(context).size.width - 210) / 2.0,
              child: Container(
                width: 200.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: secondaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: secondaryColor,
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                          offset: Offset(0, 0))
                    ]),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      channel.title,
                      style: defaultTextStyle,
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
                child: Container(
              child: InkWell(
                splashColor: secondaryColor,
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, ani1, ani2) => ChannelDetail(
                                channel: channel,
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
      ),
    );
  }

  void _loadMoreChannel() {
    if (_loginBloc.state is Authenticated) {
      _channelBloc.add(LoadMoreChannels(
          channels: _channels,
          accessToken: (_loginBloc.state as Authenticated).user.accessToken));
    }
  }
}
