import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/exceptions/api_exception.dart';
import 'package:movie_app/model/movie_model.dart';

const apiKey = '11a237a867da353565170e7c24bae74c';

class MovieServices {
  static final dio = Dio();

  static Future<Either<String, List<Movie>>> getMovieByCategory(
      {required String apiPath, required int page}) async {
    try {
      final response = await dio
          .get(apiPath, queryParameters: {'api_key': apiKey, 'page': page});

      final data = (response.data['results'] as List)
          .map((e) => Movie.fromJson(e))
          .toList();
      return Right(data);
    } on DioException catch (err) {
      return Left(Exceptions.getErrorTexxt(err));
    }
  }

  static Future<Either<String, List<Movie>>> getSearchMovie(
      {required String apiPath, required String queryText}) async {
    try {
      print('queryText: $queryText');
      final response = await dio.get(apiPath,
          queryParameters: {'api_key': apiKey, 'query': queryText});
      print(response.data);
      if ((response.data['results'] as List).isEmpty) {
        return left('Try using Another Keyword');
      } else {
        final data = (response.data['results'] as List)
            .map((e) => Movie.fromJson(e))
            .toList();
        print(data.length);
        return Right(data);
      }
    } on DioException catch (err) {
      return Left(Exceptions.getErrorTexxt(err));
    }
  }
}
