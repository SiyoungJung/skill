import 'dart:convert';
import 'dart:ui';

class ProfileModel {
  final int id;
  final String name;
  final Color color;

  ProfileModel({
    required this.id,
    required this.name,
    required this.color
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'r': color.red,
    'g': color.green,
    'b': color.blue,
  };

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      name: json['name'],
      // RGB 값을 이용하여 Color 객체 복원 (투명도는 1.0으로 고정)
      color: Color.fromRGBO(json['r'], json['g'], json['b'], 1.0),
    );
  }
}