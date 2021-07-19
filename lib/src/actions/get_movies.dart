import 'package:temayts2/src/models/movie.dart';
import 'package:temayts2/src/models/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class GetMovies with _$GetMovies implements AppAction {
  const factory GetMovies() = GetMoviesStart;

  const factory GetMovies.successful(List<Movie> movies) = GetMoviesSuccessful;

  @Implements(ErrorAction)
  const factory GetMovies.error(Object error, StackTrace stackTrace) = GetMoviesError;
}
