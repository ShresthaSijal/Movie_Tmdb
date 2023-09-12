import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/Services/movie_services.dart';
import 'package:movie_app/api.dart';
import 'package:movie_app/model/movie_state.dart';
import 'package:dartz/dartz.dart';

final searchProvider = StateNotifierProvider<MovieProvider, MovieState>((ref) =>
    MovieProvider(MovieState(
        api: Api.getSearchMovie,
        errText: '',
        isError: false,
        isLoad: false,
        isSuccess: false,
        isLoadMore: false,
        movies: [],
        page: 1)));

class MovieProvider extends StateNotifier<MovieState> {
  MovieProvider(super.state);

  Future<void> getSearchMovie({required String query}) async {
    print(query);
    state = state.copyWith(isLoad: true, isError: false, isSuccess: false);
    final response = await MovieServices.getSearchMovie(
        apiPath: state.api, queryText: query);
    response.fold(
        (l) => state = state.copyWith(
            isSuccess: false,
            isLoad: false,
            isError: true,
            errText: l,
            movies: []),
        (r) => state = state.copyWith(
            isError: false,
            isLoad: false,
            isSuccess: true,
            errText: '',
            movies: r));
  }
}
