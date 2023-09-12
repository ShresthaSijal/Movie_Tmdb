import 'package:movie_app/model/movie_model.dart';

enum MovieCategory { popular, top_rated, upcoming }

class MovieState {
  List<Movie> movies;
  final String errText;
  final bool isError;
  final bool isLoad;
  final bool isSuccess;
  final String api;
  final int page;
  final bool isLoadMore;

  MovieState(
      {required this.api,
      required this.errText,
      required this.isError,
      required this.isLoad,
      required this.isSuccess,
      required this.movies,
      required this.page,
      required this.isLoadMore});

  MovieState copyWith(
      {List<Movie>? movies,
      final String? errText,
      final bool? isError,
      final bool? isLoad,
      final bool? isSuccess,
      final String? api,
      final int? page,
      final bool? isLoadMore}) {
    return MovieState(
        api: api ?? this.api,
        errText: errText ?? this.errText,
        isError: isError ?? this.isError,
        isLoad: isLoad ?? this.isLoad,
        isSuccess: isSuccess ?? this.isSuccess,
        movies: movies ?? this.movies,
        page: page ?? this.page,
        isLoadMore: isLoadMore ?? this.isLoadMore);
  }
}
