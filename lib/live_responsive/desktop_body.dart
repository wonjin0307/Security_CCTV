import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MyDesktopBody extends StatefulWidget {
  @override
  _MyDesktopBodyState createState() => _MyDesktopBodyState();
}

class _MyDesktopBodyState extends State<MyDesktopBody> {
  @override
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
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Container(
                  width: 1100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/image/microdust_inform_background_black.jpg'),
                          fit: BoxFit.cover,
                          opacity: 150)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // 감지내역 밑에 밑줄 언더라인.
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.white))),
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "CCTV",
                                  style: TextStyle(color: Colors.white),
                                )
                              ]),
                        ),
                        Container(
                          child: Mjpeg(
                            isLive: true,
                            error: (context, error, stack) {
                              print(error);
                              print(stack);
                              return Text(error.toString(),
                                  style: TextStyle(color: Colors.red));
                            },
                            stream: 'http://127.0.0.1:5000/video',
                          ),
                        ),
                        // symmetric을 활용하기위해 맨 맡이 컨테이너를 둬서 정렬 활용.
                        Container(),
                      ]),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, bottom: 8, top: 16),
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/image/microdust_inform_background_black.jpg'),
                            fit: BoxFit.cover,
                            opacity: 150),
                      ),
                      height: 400,
                      child: Column(
                        children: [
                          Container(
                            // 감지내역 밑에 밑줄 언더라인.
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.white))),
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "날씨",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ]),
                          ),
                          // 이 부분을 기점으로 감지내역의 데이터를 넣을 리스트뷰를 넣어야한다. Container() 안에,
                          Container(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/image/microdust_inform_background_black.jpg'),
                            fit: BoxFit.cover,
                            opacity: 150),
                      ),
                      height: 500,
                      child: Column(
                        children: [
                          Container(
                            // 감지내역 밑에 밑줄 언더라인.
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.white))),
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "감지 내역",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ]),
                          ),
                          // 이 부분을 기점으로 감지내역의 데이터를 넣을 리스트뷰를 넣어야한다. Container() 안에,
                          Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ])),
    );
  }
}
