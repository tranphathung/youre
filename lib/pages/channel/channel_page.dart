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
            child: Center(
              child: Text(
                "loaded {${channels.length.toString()}}",
                style: defaultTextStyle,
              ),
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
}
