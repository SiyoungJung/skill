import 'package:flutter/material.dart';
import 'package:hw1/data/service/movie_service.dart';

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
    _load();
    initAction();
  }

  void _load() async {
    await movieService.loadGenreList();
     setState(() {
    });
  }


  late Image? mainPoster;

  Future<void> loadPoster(String poster_path) async {
    const _imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
     mainPoster = Image.network(
      '$_imageBaseUrl${poster_path}',
      fit: BoxFit.cover,
    );
     setState(() {
     });
  }

  void initAction() async {
    await movieService.loadMovieList();
    await loadPoster(movieService.topRatedMovieList[0].poster_path);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.widthOf(context),
          height: 50,
          decoration: BoxDecoration(
            color: Color(232935),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18),
            ),
          ),
          child: SizedBox(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: movieService.genreList.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final genre = movieService.genreList[index];

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF232935),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      genre.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ),
        SizedBox(child: mainPoster)
      ],
    );
  }
}
