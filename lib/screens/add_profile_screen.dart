import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hw1/data/model/profile_model.dart';
import 'package:hw1/etc/color_set.dart';
import '../data/service/profile_service.dart';

class AddProfileScreen extends StatefulWidget {
  const AddProfileScreen({super.key});

  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final ProfileService _profileService = ProfileService();

  // 랜덤 색상을 위해 미리 정의
  late Color _randomColor;

  @override
  void initState() {
    super.initState();
    // 화면에 들어올 때 랜덤한 프로필 색상 지정
    _randomColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // 저장 로직
  Future<void> _saveProfile() async {
    if (_nameController.text.isEmpty) return;

    final newProfile = ProfileModel(
      id: DateTime.now().millisecondsSinceEpoch,
      name: _nameController.text,
      color: _randomColor,
    );

    await _profileService.addProfile(newProfile);

    if (!mounted) return;
    Navigator.pop(context, true); // true를 반환하여 이전 화면 갱신 유도
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white), // 뒤로가기 버튼 흰색
        title: const Text(
          "프로필 추가",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "취소",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// 중앙 프로필 이미지 (원형)
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: _randomColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Center(
                  child: Text(
                    _nameController.text.isNotEmpty
                        ? _nameController.text[0]
                        : "", // 입력된 이름의 첫 글자 표시
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              /// 텍스트 입력 필드
              TextField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {}); // 입력할 때마다 중앙 글자 업데이트
                },
                decoration: InputDecoration(
                  hintText: "이름을 입력하세요",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// 저장하기 버튼 (요청하신 주황색 컨테이너)
              GestureDetector(
                onTap: _saveProfile,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.orange, // 요청하신 주황색
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Text(
                      "저장하기",
                      style: TextStyle(
                        color: Colors.black, // 또는 Colors.white
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}