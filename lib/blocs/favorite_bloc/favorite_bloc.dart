import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youre/blocs/blocs.dart';
import 'package:youre/models/video.dart';
import 'package:youre/services/api_favorite.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final LoginBloc loginBloc;
  FavoriteBloc({this.loginBloc}) {
    loginBloc.listen((state) {
      if (state is Authenticated) {
        this.add(LoadFavorite(accessToken: state.user.accessToken));
      }
    });
  }
  @override
  FavoriteState get initialState => FavoriteLoading();

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
    if (event is LoadFavorite) {
      yield* _mapLoadFavoriteToState(event.accessToken);
    } else if (event is UpdateFavorite) {
      yield* _mapUpdateFavoriteToState(event.accessToken, event.videos);
    }
  }

  Stream<FavoriteState> _mapLoadFavoriteToState(String accessToken) async* {
    List<Video> videos =
        await ApiFavorite.getInstance().loadFavoriteVideos(accessToken);
    yield FavoriteLoaded(videos: videos);
  }

  Stream<FavoriteState> _mapUpdateFavoriteToState(
      String accessToken, List<Video> videos) async* {
    List<Video> moreVideos =
        await ApiFavorite.getInstance().loadFavoriteVideos(accessToken);
    videos.addAll(moreVideos);
    yield FavoriteLoaded(videos: videos);
  }
}
