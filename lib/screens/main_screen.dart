import 'package:flutter/material.dart';
import 'package:hw1/data/model/profile_model.dart';
import 'package:hw1/screens/profile_screen.dart';
import 'package:hw1/screens/search_screen.dart';

import '../etc/color_set.dart';
import '../etc/widget/custom_bottom_navigation_bar.dart';
import 'comming_soon_screen.dart';
import 'download_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  final ProfileModel? profile;

  const MainScreen({
    super.key,
    this.profile,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomeScreen(),
      const CommingSoonScreen(),
      const DownloadScreen(),
      const SearchScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: pages[_currentIndex],

      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        selectedProfile: widget.profile,
      ),
    );
  }
}