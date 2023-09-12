import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/Provider/search_provider.dart';

class SearchPage extends StatelessWidget {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final movieState = ref.watch(searchProvider);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: searchController,
                    onFieldSubmitted: (value) {
                      ref
                          .read(searchProvider.notifier)
                          .getSearchMovie(query: value.trim());
                      searchController.clear();
                    },
                    decoration: InputDecoration(
                      hintText: 'Search Here...',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: movieState.isLoad
                          ? Center(child: CircularProgressIndicator())
                          : movieState.isError
                              ? Center(child: Text(movieState.errText))
                              : GridView.builder(
                                  itemCount: movieState.movies.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: 2 / 3),
                                  itemBuilder: (context, index) {
                                    final movie = movieState.movies[index];
                                    return CachedNetworkImage(
                                      errorWidget: (c, s, d) => Image.asset(
                                          'assets/images/movie.png'),
                                      progressIndicatorBuilder:
                                          (context, url, progress) => Center(
                                              child: SpinKitFadingCube(
                                        color: Colors.pink,
                                        size: 50.0,
                                      )),
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/w600_and_h900_bestv2${movie.poster_path}',
                                    );
                                  }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
