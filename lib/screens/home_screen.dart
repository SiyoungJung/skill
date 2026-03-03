import 'package:flutter/material.dart';
import 'package:hw1/data/service/movie_service.dart';

import '../etc/etc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MovieService movieService = MovieService();

  @override
  void initState() {
    super.initState();
    initAction();
  }

  Image? mainPoster = null;

  Future<void> loadMainPoster(String poster_path) async {
    const _imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
    mainPoster = Image.network(
      '$_imageBaseUrl${poster_path}',
      fit: BoxFit.cover,
    );
  }

  List<Image> topRatedMoviePosterList = [];
  List<Image> playingMoviePosterList = [];
  List<Image> recentlyReleasedMoviePosterList = [];

  void initAction() async {
    await movieService.loadGenreList();
    setState(() {});
    await movieService.loadTopRatedMovieList();
    setState(() {});
    await loadMainPoster(movieService.topRatedMovieList[0].poster_path);
    setState(() {});
    for (int i = 0; movieService.topRatedMovieList.length > i; i++) {
      topRatedMoviePosterList.add(await etc.loadPoster(
        movieService.topRatedMovieList[i].poster_path,
      ));
    }
    setState(() {});
    await movieService.loadPlayingMovieList();
    setState(() {});
    for (int i = 0; movieService.nowPlayingMovieList.length > i; i++) {
      playingMoviePosterList.add(await etc.loadPoster(
        movieService.topRatedMovieList[i].poster_path,
      ));
    }
    setState(() {});
    await movieService.loadRecentlyReleasedMovieList();
    setState(() {});
    for (int i = 0; i < movieService.recentlyReleasedMovieList.length; i++) {
      recentlyReleasedMoviePosterList.add(await etc.loadPoster(
        movieService.recentlyReleasedMovieList[i].poster_path,
      ));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              if (mainPoster != null)
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.heightOf(context) - 110,
                  child: mainPoster!,
                )
              else
                const SizedBox(
                  height: 300,
                  child: Center(child: CircularProgressIndicator()),
                ),
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 21),
                  Text(
                    "방영중인 작품",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (!playingMoviePosterList.isEmpty)
                SizedBox(
                  height: 150,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return playingMoviePosterList[index];
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 18),
                    itemCount: movieService.nowPlayingMovieList.length,
                  ),
                )
              else
                const SizedBox(
                  height: 300,
                  child: Center(child: CircularProgressIndicator()),
                ),
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 21),
                  Text(
                    "인기 작품",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (!topRatedMoviePosterList.isEmpty)
                SizedBox(
                  height: 150,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return topRatedMoviePosterList[index];
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 18),
                    itemCount: movieService.topRatedMovieList.length,
                  ),
                )
              else
                const SizedBox(
                  height: 300,
                  child: Center(child: CircularProgressIndicator()),
                ),
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 21),
                  Text(
                    "최근 개봉",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (!recentlyReleasedMoviePosterList.isEmpty)
                SizedBox(
                  height: 150,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return recentlyReleasedMoviePosterList[index];
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 18),
                    itemCount: movieService.recentlyReleasedMovieList.length,
                  ),
                )
              else
                const SizedBox(
                  height: 300,
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.widthOf(context),
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xFF232935),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18),
            ),
          ),
          child: Row(
            children: [
              SizedBox(width: 13),
              Image.asset('assets/images/showtime-logo.png'),
              const SizedBox(width: 13),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: movieService.genreList.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final genre = movieService.genreList[index];
                      return Center(
                        child: Text(
                          genre.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
