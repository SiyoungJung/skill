class MovieModel {
  final bool adult;
  final String backdrop_path;
  final List<int> genre_ids;
  final int id;
  final String original_language;
  final String original_title;
  final String overview;
  final double popularity;
  final String poster_path;
  final String release_date;
  final String title;
  final bool video;
  final double vote_average;
  final int vote_count;

  MovieModel({
    required this.adult,
    required this.backdrop_path,
    required this.genre_ids,
    required this.id,
    required this.original_language,
    required this.original_title,
    required this.overview,
    required this.popularity,
    required this.poster_path,
    required this.release_date,
    required this.title,
    required this.video,
    required this.vote_average,
    required this.vote_count,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      adult: json['adult'],
      backdrop_path: json['backdrop_path'] as String? ?? '',
      genre_ids: List<int>.from(json['genre_ids'] ?? []),
      id: json['id'],
      original_language: json['original_language'],
      original_title: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      poster_path: json['poster_path'] as String? ?? '',
      release_date: json['release_date'],
      title: json['title'],
      video: json['video'],
      vote_average: json['vote_average'],
      vote_count: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdrop_path,
      'genre_ids': genre_ids,
      'id': id,
      'original_language': original_language,
      'original_title': original_title,
      'overview': overview,
      'popularity': popularity,
      'poster_path': poster_path,
      'release_date': release_date,
      'title': title,
      'video': video,
      'vote_average': vote_average,
      'vote_count': vote_count,
    };
  }
}
