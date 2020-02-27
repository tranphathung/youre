import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youre/blocs/blocs.dart';
import 'package:youre/models/channel_models.dart';
import 'package:youre/utils/constants.dart';

class ChannelDetail extends StatefulWidget {
  final Channel channel;
  ChannelDetail({this.channel});

  @override
  _ChannelDetailState createState() => _ChannelDetailState();
}

class _ChannelDetailState extends State<ChannelDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: BlocBuilder<ChannelBloc, ChannelState>(
        builder: (context, state) {
          if (state is ChannelDetailLoaded) {
            return Container(
              child: Text('Loaded'),
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
      ),
    );
  }
}
