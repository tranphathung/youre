import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const LinearGradient eveningSunshine = LinearGradient(
    colors: [Color(0xFFb92b27), Color(0xFF1565C0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

const LinearGradient witchingHour = LinearGradient(
    colors: [Color(0xFFc31432), Color(0xFF240b36)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

const secondaryColor = Color(0xFFe11a38);
const primaryColor = Color(0xFF0b0b0c);
const blueAccentColor = Color(0xFF150eac);
const lightBlack = Color(0xFF242428);
const darkRedColor = Color(0xFF850c1a);

const defaultTextStyle =
    TextStyle(fontFamily: "Lato", fontSize: 16.0, color: Colors.white);

const defaultPadding = EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0);

class YoutubeVideoConstant {
  static const chartMostPopular = "mostPopular";
  static const partSnippet = "snippet";
  static const partContentDetails = "contentDetails";
  static const partStatistics = "statistics";
}
