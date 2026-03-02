import 'package:flutter/material.dart';
import 'package:hw1/etc/color_set.dart';
import '../data/model/profile_model.dart';
import '../data/service/profile_service.dart';
import '../etc/widget/profile.dart' as profile_widget;
import 'add_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                child: Text(
                  "프로필",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Center(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...profiles.map(
                                (profile) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: profile_widget.Profile(
                                profile.name,
                                color: profile.color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    GestureDetector(
                      onTap: _navigateToAddProfile,
                      child: Column(
                        children: const [
                          Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                            size: 50, // 아이콘 크기 키움
                          ),
                          SizedBox(height: 8),
                          Text(
                            "프로필 추가",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.only(left: 20, bottom: 10),
                child: Text(
                  "일반 설정",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildSettingItem("프로필 수정"),
              _buildSettingItem("언어 변경"),
              _buildSettingItem("새 기기 연결하기"),
              _buildSettingItem("앱 권한 설정"),
              _buildSettingItem("로그아웃"),
              _buildSettingItem("이용약관 동의"),
              _buildSettingItem("개인정보 처리 방침"),
              _buildSettingItem("오픈 소스 활용 안내"),
              _buildSettingItem("기타 문의")
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildSettingItem(String title) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white24, width: 0.5),
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.white),
        onTap: () {
        },
      ),
    );
  }
}