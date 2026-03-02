import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/profile_model.dart';

class ProfileService {
  static const _key = 'profiles';

  Future<List<ProfileModel>> loadProfiles() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null) return [];

    final List decoded = jsonDecode(jsonString);
    return decoded
        .map((e) => ProfileModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> addProfile(ProfileModel profile) async {
    final profiles = await loadProfiles();
    profiles.add(profile);
    await _save(profiles);
  }

  Future<void> removeProfile(int id) async {
    final profiles = await loadProfiles();
    profiles.removeWhere((p) => p.id == id);
    await _save(profiles);
  }

  Future<void> _save(List<ProfileModel> profiles) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = profiles.map((p) => p.toJson()).toList();
    prefs.setString(_key, jsonEncode(jsonList));
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_key);
  }
}