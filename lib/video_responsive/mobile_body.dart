import 'package:flutter/material.dart';


class MyMobileBody extends StatefulWidget {
  @override
  _MyMobileBodyState createState() => _MyMobileBodyState();
}

class _MyMobileBodyState extends State<MyMobileBody> {

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
          child: Column(
            children: [
              // youtube video
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/image/microdust_inform_background_black.jpg'),
                              fit: BoxFit.cover,
                              opacity: 150)),
                  ),
                ),
              ),

              // comment section & recommended videos
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8,top:16 ),
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
                            border: Border(bottom: BorderSide(color: Colors.white)) 
                          ),
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Text("감지내역",style: TextStyle(
                              color: Colors.white
                            ),)
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
                            border: Border(bottom: BorderSide(color: Colors.white)) 
                          ),
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Text("카메라",style: TextStyle(
                              color: Colors.white
                            ),)
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
                            border: Border(bottom: BorderSide(color: Colors.white)) 
                          ),
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Text("금일 날씨",style: TextStyle(
                              color: Colors.white
                            ),)
                          ]),
                        ),
                        // 이 부분을 기점으로 감지내역의 데이터를 넣을 리스트뷰를 넣어야한다. Container() 안에, 
                        Container(),
                        ],
                      ),
                    ),
                  ],
                ),)
            ]))
        ])),
    );
  }
}