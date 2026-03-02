import 'package:flutter/material.dart';
import 'package:hw1/data/model/profile_model.dart';
import 'package:hw1/etc/widget/profile.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final ProfileModel? selectedProfile;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.selectedProfile,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF1F2430),
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.white,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
        const BottomNavigationBarItem(icon: Icon(Icons.playlist_play), label: '공개예정'),
        const BottomNavigationBarItem(icon: Icon(Icons.download), label: '다운로드'),
        const BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),

        BottomNavigationBarItem(
          icon: SizedBox(
            width: 30,
            height: 30,
            child: selectedProfile != null
                ? FittedBox(
              fit: BoxFit.contain,
              child: Profile(
                selectedProfile!.name,
                color: selectedProfile!.color,
              ),
            )
                : const Icon(Icons.account_circle),
          ),
          label: '프로필',
        ),
      ],
    );
  }
}