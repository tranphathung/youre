import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:youre/models/video.dart';
import 'package:youre/utils/key.dart';

class ApiChannelDetail {
  ApiChannelDetail._();
  static const String _BASEURL = 'www.googleapis.com';
  static const String _CHANNELAPI = '/youtube/v3/channels';
  static const String _PLAYLISTITEMSAPI = '/youtube/v3/playlistItems';
  String _channelVidesPageToken = '';
  static ApiChannelDetail _apiChannelDetail;
  static ApiChannelDetail getInstance() {
    if (_apiChannelDetail == null) {
      _apiChannelDetail = ApiChannelDetail._();
      return _apiChannelDetail;
    }
    return _apiChannelDetail;
  }

  Future<List<Video>> getChannelDetailVideos(String channelId) async {
    String uploadId = await getUploadId(channelId);
    print(uploadId);
    Map<String, String> params = {
      "part": "snippet,contentDetails",
      "playlistId": uploadId,
      "maxResults": "15",
      "pageToken": _channelVidesPageToken,
      "key": API_KEY,
    };

    Uri uri = Uri.https(_BASEURL, _PLAYLISTITEMSAPI, params);

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    try {
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        _channelVidesPageToken = data['nextPageToken'] ?? '';
        List<dynamic> jsons = data['items'];
        List<Video> videos = List();
        jsons.forEach((json) => videos.add(Video.fromPlaylistItem(json)));
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

  Future<String> getUploadId(String channelId) async {
    Map<String, String> params = {
      "part": "contentDetails",
      "id": channelId,
      "key": API_KEY
    };

    Uri uri = Uri.https(_BASEURL, _CHANNELAPI, params);

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    try {
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body)['items'][0];
        String uploadId = data['contentDetails']['relatedPlaylists']['uploads'];
        return uploadId;
      } else {
        print(json.decode(response.body)['error']['message']);
        return '';
      }
    } catch (e) {
      print(e);
      return '';
    }
  }
}
