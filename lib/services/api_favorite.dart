import 'dart:convert';
import 'dart:io';
import 'package:youre/models/video.dart';
import 'package:http/http.dart' as http;

class ApiFavorite {
  ApiFavorite._();
  static ApiFavorite _apiFavorite;
  static ApiFavorite getInstance() {
    if (_apiFavorite == null) {
      _apiFavorite = ApiFavorite._();
      return _apiFavorite;
    }
    return _apiFavorite;
  }

  static const String _BASEURL = 'www.googleapis.com';
  static const String _VIDEOSAPI = '/youtube/v3/videos';
  String _pageToken = '';

  Future<List<Video>> loadFavoriteVideos(String accessToken) async {
    Map<String, String> params = {
      "part": "snippet, contentDetails, statistics",
      "maxResults": '15',
      "myRating": "like",
      "pageToken": _pageToken
    };

    Uri uri = Uri.https(_BASEURL, _VIDEOSAPI, params);

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $accessToken"
    };

    try {
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        _pageToken = data['nextPageToken'] ?? '';
        List<dynamic> listJsons = data['items'];
        List<Video> videos = List();
        listJsons.forEach((json) => videos.add(Video.fromMapPopular(json)));
        return videos;
      } else {
        print(json.decode(response.body)['error']['message']);
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
