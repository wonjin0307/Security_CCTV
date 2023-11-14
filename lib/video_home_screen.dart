import 'package:flutter/material.dart';
import 'package:frontend/video_responsive/desktop_body.dart';
import 'package:frontend/video_responsive/mobile_body.dart';
import 'package:frontend/video_responsive/responsive_layout.dart';

class video_home_screen extends StatefulWidget {
  const video_home_screen({Key? key}) : super(key: key);

  @override
  _home_screenState createState() => _home_screenState();
}

class _home_screenState extends State<video_home_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileBody: MyMobileBody(),
        desktopBody: MyDesktopBody(),
      ),
    );
  }
}
