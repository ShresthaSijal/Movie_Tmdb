import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/Services/movie_services.dart';
import 'package:movie_app/api.dart';
import 'package:movie_app/model/movie_state.dart';
import 'package:dartz/dartz.dart';

final popularProvider = StateNotifierProvider<MovieProvider, MovieState>(
    (ref) => MovieProvider(MovieState(
        api: Api.popular,
        errText: '',
        isError: false,
        isLoad: false,
        isSuccess: false,
        isLoadMore: false,
        movies: [],
        page: 1)));
final topRatedProvider = StateNotifierProvider<MovieProvider, MovieState>(
    (ref) => MovieProvider(MovieState(
        api: Api.topRated,
        errText: '',
        isError: false,
        isLoad: false,
        isSuccess: false,
        isLoadMore: false,
        movies: [],
        page: 1)));
final upcomingProvider = StateNotifierProvider<MovieProvider, MovieState>(
    (ref) => MovieProvider(MovieState(
        api: Api.upComing,
        errText: '',
        isError: false,
        isLoad: false,
        isSuccess: false,
        isLoadMore: false,
        movies: [],
        page: 1)));

class MovieProvider extends StateNotifier<MovieState> {
  MovieProvider(super.state) {
    getMovieByCategory();
  }

  Future<void> getMovieByCategory() async {
    state = state.copyWith(
        isLoad: state.isLoadMore ? false : true,
        isError: false,
        isSuccess: false);
    final response = await MovieServices.getMovieByCategory(
        apiPath: state.api, page: state.page);
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
            movies: [...state.movies, ...r]));
  }

  Future<void> loadMoreMovie() async {
    state = state.copyWith(page: state.page + 1, isLoadMore: true);
    getMovieByCategory();
  }
}
