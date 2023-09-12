import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:movie_app/Provider/movie_provider.dart';
import 'package:movie_app/View/detail_page..dart';
import 'package:movie_app/model/movie_state.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TabBarWidget extends StatelessWidget {
  final MovieCategory movieCategory;
  final String pageKey;
  const TabBarWidget(
      {Key? key, required this.movieCategory, required this.pageKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final movieState = movieCategory == MovieCategory.popular
          ? ref.watch(popularProvider)
          : movieCategory == MovieCategory.top_rated
              ? ref.watch(topRatedProvider)
              : ref.watch(upcomingProvider);
      if (movieState.isLoad) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text(
              'Loading',
              style: TextStyle(fontSize: 20),
            )
          ],
        ));
      } else if (movieState.isError) {
        return Text('${movieState.errText}');
      } else {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: NotificationListener(
            onNotification: (ScrollEndNotification onNotification) {
              final before = onNotification.metrics.extentBefore;
              final max = onNotification.metrics.maxScrollExtent;
              if (before == max) {
                if (movieCategory == MovieCategory.popular) {
                  ref.read(popularProvider.notifier).loadMoreMovie();
                } else if (movieCategory == MovieCategory.top_rated) {
                  ref.read(topRatedProvider.notifier).loadMoreMovie();
                } else {
                  ref.read(upcomingProvider.notifier).loadMoreMovie();
                }
              }
              return true;
            },
            child: GridView.builder(
                key: PageStorageKey<String>(pageKey),
                itemCount: movieState.movies.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2 / 3),
                itemBuilder: (context, index) {
                  final movie = movieState.movies[index];
                  return InkWell(
                    onTap: () {
                      Get.to(() => DetailPage(movie));
                    },
                    child: CachedNetworkImage(
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                              child: SpinKitFadingCube(
                        color: Colors.pink,
                        size: 50.0,
                      )),
                      imageUrl:
                          'https://image.tmdb.org/t/p/w600_and_h900_bestv2${movie.poster_path}',
                    ),
                  );
                }),
          ),
        );
      }
    });
  }
}
