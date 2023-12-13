import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_win/video_player_win.dart';

class MyMobileBody extends StatefulWidget {
  @override
  _MyMobileBodyState createState() => _MyMobileBodyState();
}

class _MyMobileBodyState extends State<MyMobileBody> {
  ScrollController _scrollController = ScrollController();
  List<String> resultList = [];
  bool isLoading = false;
  String resultMessage = '';

  File? _selectedVideo;
  late VideoPlayerController _videoPlayerController;
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(
        'C:/Users/anyang/Desktop/project/frontend/assets/fish_video.mp4');
  }

  Future<File?> _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'mkv', 'avi'],
    );

    if (result != null) {
      return File(result.files.single.path!);
    } else {
      return null;
    }
  }

  Future<void> _uploadVideo(File videoFile) async {
    setState(() {
      isLoading = true;
      resultList = [];
    });

    try {
      var url = Uri.parse('http://127.0.0.1:5000/upload');

      var request = http.MultipartRequest('POST', url);
      request.files.add(
        await http.MultipartFile.fromPath(
          'video',
          videoFile.path,
        ),
      );

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      setState(() {
        isLoading = false;
        resultMessage =
            response.statusCode == 200 ? '디택션이 완성되었습니다.' : '디택션이 아직 완성되지않았습니다.';
      });
      if (response.statusCode == 200) {
        print('동영상 업로드 성공');
        List<dynamic> jsonMap = jsonDecode(responseBody);
        setState(() {
          resultList.add(jsonMap.toString());
          print(resultList);
        });
      } else {
        print('동영상 업로드 실패: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }

  Future<void> _getProcessedVideo() async {
    try {
      if (_selectedVideo == null) {
        print("No video selected");
      }

      String downloadUrl = "http://127.0.0.1:5000/get_processed_video";
      dynamic setPath = 'C:/Users/anyang/Desktop/project/frontend/assets';

      http.Response response = await http.get(Uri.parse(downloadUrl));

      if (response.statusCode == 200) {
        // Assuming the server returns the video file in the response body.
        // You may need to adjust this based on how the server is set up.
        List<int> videoBytes = response.bodyBytes;
        File videoFile = File('$setPath/fish_video.mp4');
        await videoFile.writeAsBytes(videoBytes);
      } else {
        print(
            "Failed to download video. Server returned ${response.statusCode}");
      }
    } catch (error) {
      print("Error downloading video: $error");
    }
  }

  Future<void> _pickAndPlayVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'mkv', 'avi'],
    );
    if (result != null) {
      File selectedVideo = File(result.files.single.path!);

      // Copy the selected video to the app's temporary directory
      final appDir = await getTemporaryDirectory();
      final copiedVideoPath = '${appDir.path}/selected_video.mp4';
      await selectedVideo.copy(copiedVideoPath);

      setState(() {
        _selectedVideo = File(copiedVideoPath);
        _videoPlayerController = VideoPlayerController.file(_selectedVideo!);
        _videoPlayerController.initialize().then((_) {
          setState(() {});
          _videoPlayerController.play();
        });
      });
    }
  }

  void myDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog.fullscreen(
          backgroundColor: Colors.blue.withOpacity(0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                  style: TextStyle(color: Colors.white),
                  "동영상 선택 : 사용자 폴더에서 동영상 선택\n\n동영상 내려받기 : 사용자 폴더안에있는SSC/assets에 저장됩니다. \nEx) C:/Users/anyang/Desktop/project/assets \n\n저장된 비디오 보기 : assets폴더에있는 비디오를 선택"),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              )
            ],
          ),
        );
      },
    );
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
              // youtube video
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
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    myDialog(context);
                                  },
                                  icon: const Icon(
                                    Icons.question_mark,
                                    color: Colors.white,
                                  ),
                                ),
                                if (isLoading) CircularProgressIndicator(),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(resultMessage),
                                SizedBox(
                                  height: 20,
                                ),
                                _selectedVideo != null
                                    ? Stack(children: [
                                        VideoPlayer(_videoPlayerController),
                                        Positioned(
                                            bottom: 0,
                                            child: Column(children: [
                                              ValueListenableBuilder(
                                                valueListenable:
                                                    _videoPlayerController,
                                                builder:
                                                    ((context, value, child) {
                                                  int minute =
                                                      _videoPlayerController
                                                          .value
                                                          .position
                                                          .inMinutes;
                                                  int second =
                                                      _videoPlayerController
                                                              .value
                                                              .position
                                                              .inSeconds %
                                                          60;
                                                  return Text("$minute:$second",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6!
                                                          .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              backgroundColor:
                                                                  Colors
                                                                      .black54));
                                                }),
                                              ),
                                              SizedBox(height: 20),
                                              ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty.all(
                                                              Colors.black
                                                                  .withOpacity(
                                                                      0.5))),
                                                  onPressed: () =>
                                                      _videoPlayerController
                                                          .play(),
                                                  child: const Text(
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                      "Play")),
                                              SizedBox(height: 20),
                                              ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5))),
                                                  onPressed: () =>
                                                      _videoPlayerController
                                                          .pause(),
                                                  child: const Text(
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                      "Pause")),
                                            ])),
                                      ])
                                    : Text(
                                        style: TextStyle(color: Colors.white),
                                        'No video selected'),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black.withOpacity(0.5))),
                                  onPressed: () async {
                                    File? videoFile = await _pickVideo();
                                    if (videoFile != null) {
                                      await _uploadVideo(videoFile);
                                    }
                                  },
                                  child: Text(
                                      style: TextStyle(color: Colors.white),
                                      '동영상 선택'),
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black.withOpacity(0.5))),
                                  onPressed: _getProcessedVideo,
                                  child: Text(
                                      style: TextStyle(color: Colors.white),
                                      ' 동영상 내려받기 '),
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black.withOpacity(0.5))),
                                  onPressed: _pickAndPlayVideo,
                                  child: Text(
                                      style: TextStyle(color: Colors.white),
                                      '저장된 비디오 보기'),
                                ),
                              ]),
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
                                    "감지내역",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ]),
                          ),
                          // 이 부분을 기점으로 감지내역의 데이터를 넣을 리스트뷰를 넣어야한다. Container() 안에,
                          Container(
                            constraints: BoxConstraints(maxHeight: 300),
                            child: ListView.builder(
                                controller: _scrollController,
                                itemCount: resultList.length,
                                itemBuilder: (context, index) {
                                  List<String> splitValues =
                                      resultList[index].split('},');

                                  String formattedString =
                                      splitValues.join('}\n\n');
                                  return ListTile(
                                    title: Text(
                                      formattedString,
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

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }
}
