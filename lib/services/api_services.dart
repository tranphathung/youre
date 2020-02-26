import 'dart:convert';
import 'dart:io';
import 'package:youre/models/channel_models.dart';
import 'package:youre/models/video.dart';
import 'package:youre/utils/key.dart';
import 'package:http/http.dart' as http;

class APIService {
  APIService._();
  static final APIService api_instance = APIService._();
  final String _base_URL = 'www.googleapis.com';
  String _nextPageToken = '';
  String _popularPageToken = '';

  Future<Channel> fetchChannel({String channelId}) async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': API_KEY
    };
    Uri uri = Uri.https(_base_URL, '/youtube/v3/channels', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      Channel channel = Channel.fromMap(data);
      channel.videos =
          await fetchVideosFromPlaylist(playlistId: channel.uploadPlaylistID);
      return channel;
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

  Future<List<Video>> fetchVideosFromPlaylist({String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': _nextPageToken,
      'key': API_KEY
    };

    Uri uri = Uri.https(_base_URL, 'youtube/v3/playlistItems', parameters);

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    try {
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        _nextPageToken = data['nextPageToken'] ?? '';
        List<dynamic> videosJson = data['items'];

        List<Video> videos = [];
        videosJson.forEach(
            (json) => videos.add(Video.fromMapPopular(json['snippet'])));

        return videos;
      } else {
        return [];
      }
    } catch (e) {
      throw e;
    }
  }
}
