import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/home_screen.dart';

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
          'assets/backimg.png',
          fit: BoxFit.cover, //지정된 영역을 꽉 채운다
          width: double.infinity, //가로 너비 채우기
          height: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => home_screen()));
                    },
                    icon: SvgPicture.asset(
                      'assets/logo/waitlogo_02.svg',
                      width: 350.0,
                      height: 350.0,
                    ))
              ],
            ),
          ),
        ),
      ])),
    );
  }
}
