import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:youre/models/channel_models.dart';
import 'package:youre/models/video.dart';
import 'package:youre/utils/key.dart';
import 'package:http/http.dart' as http;

class APIService {
  
  APIService._();
  static final APIService api_instance = APIService._();
  final String _base_URL = 'www.googleapis.com';
  String _subscriptionPageToken = '';
  String _popularPageToken = '';

  Future<List<Channel>> fetchSubscriptionChannels(
      {@required String accessToken,
      List<String> parts,
      String maxResults,
      bool mine: true}) async {
    Map<String, String> parameters = {
      'part': parts.join(","),
      'pageToken': _subscriptionPageToken ?? '',
      "mine": mine.toString(),
      "maxResults": maxResults,
      'key': API_KEY
    };

    Uri uri = Uri.https(_base_URL, '/youtube/v3/subscriptions', parameters);

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $accessToken'
    };

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      _subscriptionPageToken = data['nextPageToken'];
      List<dynamic> items = data['items'];
      return items.map((json) => Channel.fromSubscription(json)).toList();
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Video>> fetchPopularVideos(
      {String chart: "mostPopular",
      List<String> parts,
      String regionCode: 'US'}) async {
    Map<String, String> parameters = {
      "part": parts.join(","),
      "chart": chart,
      "regionCode": regionCode,
      "pageToken": _popularPageToken,
      "maxResults": "15",
      "key": API_KEY
    };

    Uri uri = Uri.https(_base_URL, 'youtube/v3/videos', parameters);

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json'
    };
    Map<String, dynamic> map = Map();
    try {
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        List<Video> popularVideos = List();
        dynamic data = json.decode(response.body);
        map['totalResult'] = data['pageInfo']['totalResults'];
        _popularPageToken =
            data['nextPageToken'] != null ? data['nextPageToken'] : '';
        List<dynamic> videosJson = data['items'];
        videosJson
            .forEach((json) => popularVideos.add(Video.fromMapPopular(json)));
        return popularVideos;
      } else {
        String message = json.decode(response.body)['error']['message'];
        print("${response.statusCode}: $message");
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
