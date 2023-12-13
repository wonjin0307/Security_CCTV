import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class MyMobileBody extends StatefulWidget {
  @override
  _MyMobileBodyState createState() => _MyMobileBodyState();
}

class _MyMobileBodyState extends State<MyMobileBody> {
  ScrollController _scrollController = ScrollController();
  late io.Socket socket;
  List<String> dataList = ["감지내역이 없습니다."];
  void initState() {
    super.initState();
    socket = io.io('http://127.0.0.1:5000', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.onConnect((_) {
      // 디버깅
      print('Connected');
      socket.emit('get_data');
    });

    socket.on('send_data', (counts_dict) {
      // 디버깅
      print('Received data: $counts_dict');

      setState(() {
        dataList.add(counts_dict.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
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
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 16 / 14,
                  child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Column(children: [
                        Container(
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
                                ),
                              ]),
                        ),
                        Container(
                          child: Mjpeg(
                            width: 600,
                            height: 500,
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
                      ])),
                ),
              ),

              // comment section & recommended videos
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, bottom: 8, top: 16),
                  children: <Widget>[
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      height: 700,
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
                                    "감지내역",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ]),
                          ),
                          // 이 부분을 기점으로 감지내역의 데이터를 넣을 리스트뷰를 넣어야한다. Container() 안에,
                          Container(
                            constraints: BoxConstraints(maxHeight: 600),
                            child: ListView.builder(
                                controller: _scrollController,
                                itemCount: dataList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      dataList[index],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ]))
      ])),
    );
  }
}
