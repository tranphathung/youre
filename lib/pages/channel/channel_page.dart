import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youre/blocs/blocs.dart';
import 'package:youre/models/channel_models.dart';
import 'package:youre/utils/constants.dart';

class ChannelPage extends StatelessWidget {
  const ChannelPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelBloc, ChannelState>(
      builder: (context, state) {
        if (state is ChannelListLoaded) {
          List<Channel> channels = state.channels;
          return Container(
            color: primaryColor,
            child: ListView.builder(
              itemCount: channels.length,
              itemBuilder: (context, index) {
                Channel channel = channels[index];
                return _buildChannel(context, channel);
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
            )
          ],
        ),
      ),
    );
  }
}
