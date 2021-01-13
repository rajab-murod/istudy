import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import 'package:istudy/db/database_helpers.dart';
import 'package:istudy/models/lesson_model.dart';
import 'package:istudy/views/lesson_test.dart';

class LessonDetailPage extends StatefulWidget {
  final int lesson_id;

  LessonDetailPage({this.lesson_id});

  @override
  _LessonDetailPageState createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  var _lesson;
  VideoPlayerController _controller = VideoPlayerController.asset('assets/videos/chemistry/lesson_1.mp4');

  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    get_val();
    // Wrapper on top of the videoPlayerController
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 16 / 9,
      // Prepare the video to be played and display the first frame
      autoInitialize: true,
      looping: false,
      // Errors can occur for example when trying to play a video
      // from a non-existent URL
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  void get_val() async{
    var _data = await DatabaseHelper.db.get_lesson(widget.lesson_id);
    setState(() {
      _lesson = (_data as List)
          .map((e) => Lesson.fromJson(e)).toList();
    });
  }

  Future<Widget> callAsyncLessonDetail(){
    return Future.delayed(Duration(seconds: 1),
        ()=>Scaffold(
          appBar: AppBar(
            title: Text(_lesson[0].title),
          ),
          body: SingleChildScrollView(
            child: Container(
//          width: MediaQuery.of(context).size.width*0.9,
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Row(
//                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 100,
                          child: Column(
                            children: <Widget>[
                              Image.asset(_lesson[0].image, width: 200, height: 100,),
                            ],
                          ),
                        ),
                        SizedBox(width:15),
                        Container(
                          width: 150,
//                        height: 200,
                          child: Column(
                            children: <Widget>[
                              Text(_lesson[0].title,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22
                                ),
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    SizedBox(height:10),
                    Text(_lesson[0].content),
                    SizedBox(height: 10,),
                    Chewie(controller: _chewieController,),
                    SizedBox(height: 10,),
                    FlatButton(
                      child: Text('Get started'),
                      color: Colors.blueGrey,
                      textColor: Colors.white,
                      onPressed: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) => LessonTest(lesson_id: widget.lesson_id,)
                      )),
                    )
                  ],
                )
            ),
          ),
        )

    );
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: callAsyncLessonDetail(),
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data;
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

