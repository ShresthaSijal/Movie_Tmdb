import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/Services/movie_services.dart';
import 'package:movie_app/model/Video.dart';

final videoProvider =
    FutureProvider.family((ref, int id) => VideoProvider().getVideoKey(id: id));

class VideoProvider {
  static final dio = Dio();
  Future<List<Video>> getVideoKey({required int id}) async {
    try {
      final response = await dio.get(
          'https://api.themoviedb.org/3/movie/$id/videos',
          queryParameters: {
            'api_key': apiKey,
          });

      final data = (response.data['results'] as List)
          .map((e) => Video.fromJson(e))
          .toList();
      return data;
    } on DioException catch (e) {
      throw ('$e');
    }
  }
}
