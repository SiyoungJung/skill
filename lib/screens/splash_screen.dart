import 'package:flutter/material.dart';
import 'package:hw1/screens/profile_select_screen.dart';

import 'package:hw1/etc/color_set.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool skill = false;
  bool logo = false;

  void animation() async {
    await Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        skill = true;
      });
    });


    await Future.delayed(Duration(milliseconds: 1500), () {
      setState(() {
        logo = true;
      });
    });


    await Future.delayed(Duration(milliseconds: 2000), () {
      setState(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) =>
            ProfileSelectScreen(),));
      });
    });
  }

  @override
  void initState() {
    super.initState();

    animation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 390,
                child: AnimatedSlide(
                  offset: skill ? Offset(0, 0) : Offset(0, -2),
                  duration: Duration(seconds: 1),
                  child: Image.asset('assets/images/skill-logo.png'),
                ),
              ),
            ],
          ),
          SizedBox(height: 250),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: AnimatedOpacity(
                  opacity: logo ? 1 : 0,
                  duration: Duration(seconds: 1),
                  child: Image.asset("assets/images/showtime-logo.png"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
