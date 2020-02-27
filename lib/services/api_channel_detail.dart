import 'dart:convert';
import 'dart:io';
import 'package:youre/utils/constants.dart';
import 'package:youre/utils/key.dart';
import 'package:http/http.dart' as http;

class APIChannelDetail {
  APIChannelDetail._();
  static APIChannelDetail api = APIChannelDetail._();
  final String base_URL = 'www.googleapis.com';
  final String VIDEOURL = '/youtube/v3/playlistItems';
  final String PLAYLISTURL = '/youtube/v3/playlists';
  final String CHANNELURL = '/youtube/v3/channels';
  String videoPageToken = '';
  String playlistPageToken = '';

  Future<String> queryUploadId(String channelId) async {
    Map<String, dynamic> params = {
      "key": API_KEY,
      "channelId": channelId,
      "part": YoutubeVideoConstant.partContentDetails
    };

    Uri uri = Uri.https(base_URL, CHANNELURL, params);

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    try {
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body)['items'][0]['contentDetails']['uploads'];
      } else {
        print(json.decode(response.body)['error']['message']);
        return '';
      }
    } catch (e) {
      print(e);
      return '';
    }
  }
  //TODO: Make load videso from playListItems with uploads from Channel
}
