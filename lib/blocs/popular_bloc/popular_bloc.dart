import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youre/blocs/blocs.dart';
import 'package:youre/blocs/popular_bloc/popular_events.dart';
import 'package:youre/blocs/popular_bloc/popular_state.dart';
import 'package:youre/models/video.dart';
import 'package:youre/repositories/repositories.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  LoginBloc loginBloc;
  StreamSubscription _loginSub;
  PopularBloc({this.loginBloc}) {
    _loginSub = loginBloc.listen((state) {
      if (state is Authenticated) {
        this.add(LoadPopular());
      }
    });
  }

  @override
  Future<void> close() {
    _loginSub.cancel();
    return super.close();
  }

  @override
  PopularState get initialState => PopularLoading();

  @override
  Stream<PopularState> mapEventToState(PopularEvent event) async* {
    if (event is LoadPopular) {
      yield* _mapLoadPopularToState();
    } else if (event is UpdatePopular) {
      yield* _mapUpdatePopularToState(event.videos);
    }
  }

  Stream<PopularState> _mapLoadPopularToState() async* {
    List<Video> popularVideos =
        await VideoRepository.videoRepository.loadPopularVideos();
    yield PopularLoaded(videos: popularVideos);
  }

  Stream<PopularState> _mapUpdatePopularToState(List<Video> videos) async* {
    List<Video> loadUpdateVideos =
        await VideoRepository.videoRepository.loadPopularVideos();
    yield PopularLoaded(videos: videos..addAll(loadUpdateVideos));
  }
}
