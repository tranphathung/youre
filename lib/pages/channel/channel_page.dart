import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youre/blocs/blocs.dart';
import 'package:youre/models/channel_models.dart';
import 'package:youre/utils/constants.dart';

class ChannelPage extends StatefulWidget {
  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  ScrollController _scrollController;
  ChannelBloc _channelBloc;
  LoginBloc _loginBloc;
  List<Channel> _channels;
  @override
  void initState() {
    _scrollController = ScrollController(initialScrollOffset: 0);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreChannel();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
                return _buildChannel(context, channel);
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
    );
  }

  Widget _buildChannel(BuildContext context, Channel channel) {
    return Container(
      height: 220.0,
      child: Padding(
        padding: defaultPadding,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
                child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: Container(
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(channel.thumbnailUrl),
                ),
              ),
            )),
            Positioned.fill(
                child: Container(
              color: primaryColor.withOpacity(0.3),
            )),
            Positioned(
              bottom: 20.0,
              left: (MediaQuery.of(context).size.width - 230) / 2.0,
              child: Container(
                width: 200.0,
                decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          color: secondaryColor,
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                          offset: Offset(0, 0))
                    ]),
                child: Center(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
                    child: Text(
                      channel.title,
                      maxLines: 3,
                      style: defaultTextStyle,
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(child: Container(
              child: InkWell(
                onTap: () {
                  print("tap");
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
      _channelBloc.add(LoadUpdateListChannel(
          channels: _channels,
          accessToken: (_loginBloc.state as Authenticated).user.accessToken));
    }
  }
}
