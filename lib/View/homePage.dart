import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:movie_app/View/search_page.dart';
import 'package:movie_app/View/tab_bar_widget.dart';
import 'package:movie_app/model/movie_state.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 110,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Movie Tmdb',
                      style: TextStyle(fontSize: 20, color: Colors.amber),
                    ),
                    IconButton(
                        onPressed: () {
                          Get.to(() => SearchPage());
                        },
                        icon: Icon(
                          Icons.search,
                          size: 25,
                        ))
                  ]),
            ),
          ),
          bottom: TabBar(tabs: [
            Tab(
              text: 'Most Popular',
            ),
            Tab(
              text: 'Top Rated',
            ),
            Tab(
              text: 'Upcoming',
            ),
          ]),
        ),
        body: TabBarView(children: [
          TabBarWidget(
            movieCategory: MovieCategory.popular,pageKey: 'popular',
          ),
          TabBarWidget(
            movieCategory: MovieCategory.top_rated,pageKey: 'topRated',
          ),
          TabBarWidget(
            movieCategory: MovieCategory.upcoming,pageKey: 'upComing',
          ),
        ]),
      ),
    );
  }
}
