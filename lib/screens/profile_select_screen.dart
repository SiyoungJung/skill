import 'package:flutter/material.dart';
import 'package:hw1/data/model/profile_model.dart';
import 'package:hw1/etc/color_set.dart';
import '../data/service/profile_service.dart';
import 'package:hw1/etc/widget/profile.dart' as profile_widget;
import 'package:hw1/screens/main_screen.dart';
import 'package:hw1/screens/add_profile_screen.dart';

class ProfileSelectScreen extends StatefulWidget {
  const ProfileSelectScreen({super.key});

  @override
  State<ProfileSelectScreen> createState() => _ProfileSelectScreenState();
}

class _ProfileSelectScreenState extends State<ProfileSelectScreen> {
  final ProfileService _profileService = ProfileService();
  List<ProfileModel> profiles = [];

  @override
  void initState() {
    super.initState();
    _loadProfiles();
  }

  Future<void> _loadProfiles() async {
    final result = await _profileService.loadProfiles();
    setState(() {
      profiles = result;
    });
  }

  Future<void> _navigateToAddProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddProfileScreen(),
      ),
    );

    if (result == true) {
      await _loadProfiles();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "시청할 프로필을 선택하세요",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(
              height: 150,
              child: profiles.isEmpty
                  ? const Center(
                child: Text(
                  "프로필이 없습니다",
                  style: TextStyle(color: Colors.white54),
                ),
              )
                  : ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: profiles.length,
                separatorBuilder: (_, __) => const SizedBox(width: 15),
                itemBuilder: (context, index) {
                  final profile = profiles[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MainScreen(profile: profile),
                        ),
                      );
                    },
                    child: profile_widget.Profile(
                      profile.name,
                      color: profile.color,
                    ),
                  );
                },
              ),
            ),

            GestureDetector(
              onTap: _navigateToAddProfile,
              child: Column(
                children: const [
                  Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                    size: 64,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "프로필 추가",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}