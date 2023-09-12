import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/Provider/video_Provider.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:pod_player/pod_player.dart';

class DetailPage extends StatelessWidget {
  final Movie movie;
  DetailPage(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final videoData = ref.watch(videoProvider(movie.id));
          return ListView(
            children: [
              Container(
                  child: videoData.when(
                      data: (data) {
                        return PlayVideoFromNetwork(keys: data[0].key);
                      },
                      error: (error, stack) => Text('$error'),
                      loading: () => Container())),
            ],
          );
        },
      ),
    );
  }
}

class PlayVideoFromNetwork extends StatefulWidget {
  final String keys;
  PlayVideoFromNetwork({required this.keys});

  @override
  State<PlayVideoFromNetwork> createState() => _PlayVideoFromNetworkState();
}

class _PlayVideoFromNetworkState extends State<PlayVideoFromNetwork> {
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/${widget.keys}'),
        podPlayerConfig: const PodPlayerConfig(
            autoPlay: true,
            isLooping: false,
            videoQualityPriority: [720, 1080]))
      ..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PodVideoPlayer(controller: controller);
  }
}
