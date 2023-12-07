import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_win/video_player_win.dart';

class MyDesktopBody extends StatefulWidget {
  @override
  _MyDesktopBodyState createState() => _MyDesktopBodyState();
}

class _MyDesktopBodyState extends State<MyDesktopBody> {
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

      if (response.statusCode == 200) {
        print('동영상 업로드 성공');
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Video Detection",
                          style: TextStyle(color: Colors.white),
                        ),
                        _selectedVideo != null
                            ? Container(
                                constraints: BoxConstraints(
                                  maxWidth: 1000, // 원하는 최대 너비 설정
                                  maxHeight: 700, // 원하는 최대 높이 설정
                                ),
                                child: VideoPlayer(_videoPlayerController),
                              )
                            : Text('No video selected'),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            File? videoFile = await _pickVideo();
                            if (videoFile != null) {
                              await _uploadVideo(videoFile);
                            }
                          },
                          child: Text('동영상 선택 및 업로드'),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _getProcessedVideo,
                          child: Text('AI DETECTION START '),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _pickAndPlayVideo,
                          child: Text('저장된 비디오 보기'),
                        ),
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
                            opacity: 150.0),
                      ),
                      height: 950,
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
                                    "Video Detection",
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
                  ],
                ),
              )
            ],
          ),
        ),
      ])),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
