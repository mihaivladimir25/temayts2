import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:temayts2/src/actions/get_movies.dart';
import 'package:temayts2/src/data/movies_api.dart';
import 'package:temayts2/src/models/app_state.dart';
import 'package:temayts2/src/models/movie.dart';
import 'package:rxdart/rxdart.dart';

class AppEpics {
  const AppEpics({required MoviesApi moviesApi}) : _moviesApi = moviesApi;

  final MoviesApi _moviesApi;

  Epic<AppState> get epics {
    return combineEpics<AppState>(<Epic<AppState>>[
      TypedEpic<AppState, GetMovies>(_getMovies),
    ]);
  }

  Stream<Object> _getMovies(Stream<GetMovies> actions, EpicStore<AppState> store) {

    return actions
        .asyncMap((GetMovies action) => _moviesApi.getMovies(store.state.page))
        .map((List<Movie> movies) => GetMoviesSuccessful(movies))
        .onErrorReturnWith((Object error, StackTrace stackTrace) => GetMoviesError(error));
  }
}