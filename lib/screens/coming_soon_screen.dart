import 'package:flutter/material.dart';
import 'package:hw1/data/service/movie_service.dart';

import '../etc/etc.dart';

class ComingSoonScreen extends StatefulWidget {
  const ComingSoonScreen({super.key});

  @override
  State<ComingSoonScreen> createState() => _ComingSoonScreenState();
}

class _ComingSoonScreenState extends State<ComingSoonScreen> {
  MovieService movieService = MovieService();

  List<Image> upcomingMoviePosterList = [];

  void initAction() async {
    await movieService.loadUpcomingMovieList();
    final temp = <Image>[];
    for (int i = 0; i < movieService.upcomingMovieList.length; i++) {
      temp.add(
        await etc.loadPoster(movieService.upcomingMovieList[i].poster_path),
      );
    }
    if (!mounted) return;
    setState(() {
      upcomingMoviePosterList = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    initAction();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 35),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 25),
            Text(
              "To Be Realised",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Center(
          child: SizedBox(
            width: MediaQuery.widthOf(context) - 40,
            height: MediaQuery.heightOf(context) - 140,
            child: upcomingMoviePosterList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 2 / 3,
                        ),
                    itemCount: upcomingMoviePosterList.length,
                    itemBuilder: (context, index) {
                      return upcomingMoviePosterList[index];
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
