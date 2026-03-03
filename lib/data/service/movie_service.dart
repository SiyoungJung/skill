import 'dart:convert';

import 'package:http/http.dart';
import 'package:hw1/data/model/genre_model.dart';
import 'package:hw1/data/model/movie_model.dart';

class MovieService {
  static const base_url = 'https://api.themoviedb.org/3';
  static const language = 'ko-KR';
  static const region = 'KR';
  static const api_key =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlYWQwMDViZTM4ZTQyMmUwZTA3ZTVjZDk1MDBhNzliYiIsIm5iZiI6MTY1MDg4MjYzNC44ODgsInN1YiI6IjYyNjY3ODRhYWFlYzcxMDA5ZDk1YzA5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.G2yDxRl4lsPyNn61M0wfMGBK9cbm3XlMLxKeiCbbdog';

  List<GenreModel> genreList = [];

  Future<void> loadGenreList() async {
    final url = Uri.parse(
      '${base_url}/genre/movie/list?language=${language}&region=${region}',
    );
    final response = await Client().get(
      url,
      headers: {'Authorization': 'Bearer ${api_key}'},
    );

    genreList = (jsonDecode(response.body)['genres'] as List<dynamic>).map((e) {
      return GenreModel.fromJson(e);
    }).toList();
  }

  List<MovieModel> topRatedMovieList = [];

  Future<void> loadTopRatedMovieList() async {
    final url = Uri.parse(
      '${base_url}/movie/top_rated?language=${language}&region=${region}&page=1',
    );
    final response = await Client().get(
      url,
      headers: {'Authorization': 'Bearer ${api_key}'},
    );

    topRatedMovieList = (jsonDecode(response.body)['results'] as List<dynamic>)
        .map((e) {
          return MovieModel.fromJson(e);
        })
        .toList();
  }

  List<MovieModel> nowPlayingMovieList = [];

  Future<void> loadPlayingMovieList() async {
    final url = Uri.parse(
      '${base_url}/movie/now_playing?language=${language}&region=${region}&page=1',
    );
    final response = await Client().get(
      url,
      headers: {'Authorization': 'Bearer ${api_key}'},
    );

    nowPlayingMovieList =
        (jsonDecode(response.body)['results'] as List<dynamic>).map((e) {
          return MovieModel.fromJson(e);
        }).toList();
  }

  List<MovieModel> recentlyReleasedMovieList = [];

  Future<void> loadRecentlyReleasedMovieList() async {
    final url = Uri.parse('${base_url}/movie/now_playing?page=1');

    final response = await Client().get(url, headers: {'Authorization': 'Bearer ${api_key}'},);

    recentlyReleasedMovieList = (jsonDecode(response.body)['results'] as List<dynamic>).map((e) {
      return MovieModel.fromJson(e);
    }).toList();
  }

  List<MovieModel> upcomingMovieList = [];

  Future<void> loadUpcomingMovieList() async {
    final url = Uri.parse('${base_url}/movie/upcoming?language=${language}&region=${region}&page=1');
    
    final response = await Client().get(url, headers: {'Authorization': 'Bearer ${api_key}'},);

    upcomingMovieList = (jsonDecode(response.body)['results'] as List<dynamic>).map((e) {
      return MovieModel.fromJson(e);
    }).toList();
  }
}