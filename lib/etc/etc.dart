import 'package:flutter/material.dart';

_Etc etc = _Etc();

class _Etc {
  Future<Image> loadPoster(String poster_path) async {
    const _imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
    return Image.network(
      '$_imageBaseUrl${poster_path}',
      fit: BoxFit.cover,
    );
  }
}