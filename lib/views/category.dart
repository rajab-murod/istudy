import 'dart:math';

import 'package:flutter/material.dart';
import 'package:istudy/db/database_helpers.dart';
import 'package:istudy/models/category_model.dart';
import 'package:istudy/models/lesson_model.dart';
import 'package:istudy/views/lesson_detail.dart';

class CategoryPage extends StatefulWidget {
  final int category_id;

  CategoryPage({this.category_id});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  var _lessons;
  var _category;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_val();
  }

  void get_val() async{
    var _data = await DatabaseHelper.db.get_lesson_by_cat_id(widget.category_id);
    var _cat = await DatabaseHelper.db.get_category(widget.category_id);
    setState(() {
      _lessons = (_data as List)
          .map((e) => Lesson.fromJson(e)).toList();
      _category = (_cat as List)
      .map((e) => Category.fromJson(e)).toList();
    });
  }

  Future<Widget> callAsyncLesson(){
    return Future.delayed(Duration(seconds: 2),
            () => Scaffold(
              appBar: AppBar(
                title: Text('${_category[0].name}'),
              ),
              body:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 12),
                    margin: EdgeInsets.all(10),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Lessons of ${_category[0].name}',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        Text('${_lessons.length} lessons on this course',
                          style: TextStyle(
                              color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.all(12),
                        itemCount: _lessons.length,
                        itemBuilder: (BuildContext content, int index){
                          return Card(
                            margin: EdgeInsets.all(15),
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => LessonDetailPage(lesson_id: _lessons[index].id,)
                                  ));
                                },
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 130,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: Color.fromARGB(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), Random().nextInt(256)),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset(_lessons[index].image, width: 130, height: 120,)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 170,
                                      padding: EdgeInsets.only(left: 5),
                                      child: Column(
                                        children: <Widget>[
                                          Text(_lessons[index].title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                            ),

                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(Icons.star, color: Colors.amber,size: 20,),
                                              Icon(Icons.star, color: Colors.amber,size: 20,),
                                              Icon(Icons.star, color: Colors.amber,size: 20,),
                                              Icon(Icons.star, color: Colors.amber,size: 20,),
                                              Icon(Icons.star_border, color: Colors.amber,size: 20,),
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.hourglass_empty,size: 14,),
                                              Text('${_lessons[index].week} weeks',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 12
                                                ),),
                                              SizedBox(width: 4,),
                                              Icon(Icons.access_time, size: 14,),
                                              Text('${_lessons[index].hour} hrs per week',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 12
                                                ),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                )
                            ),
                          );
                        }
                    ),
                  )
                ],
              )
            )

    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: callAsyncLesson(),
      builder: (context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data;
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
