import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/live_home_screen.dart';
import 'package:frontend/video_home_screen.dart';
import 'package:frontend/live_responsive/video.dart';

class MywaitBody extends StatefulWidget {
  @override
  _MywaitBodyState createState() => _MywaitBodyState();
}

class _MywaitBodyState extends State<MywaitBody> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, //appBar 투명색
        elevation: 0.0,
      ),
      body: Container(
          child: Stack(children: [
        Image.asset(
          'assets/background_1.png',
          fit: BoxFit.cover, //지정된 영역을 꽉 채운다
          width: double.infinity, //가로 너비 채우기
          height: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => live_home_screen()));
                    },
                    icon: SvgPicture.asset(
                      'assets/logo/cctv.svg',
                      width: 120.0,
                      height: 120.0,
                    )),
                SizedBox(
                  width: 300,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => video_home_screen()));
                    },
                    icon: SvgPicture.asset(
                      'assets/logo/video.svg',
                      width: 150.0,
                      height: 150.0,
                    ))
              ],
            ),
          ),
        ),
      ])),
    );
  }
}
