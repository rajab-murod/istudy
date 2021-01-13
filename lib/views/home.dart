import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:istudy/views/category.dart';
import 'package:istudy/views/lesson_detail.dart';
import 'package:istudy/models/lesson_model.dart';
import 'package:istudy/models/category_model.dart';
import 'package:istudy/db/database_helpers.dart';
import 'package:istudy/utils/colors.dart';
import 'package:istudy/views/search.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var all_lessons;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //add lessons to db
    for(var i=0; i<Lesson.lesson_lists.length; i++){
      DatabaseHelper.db.insert_lesson(Lesson.lesson_lists[i]);
    }

    //add categories to db
    for(var i=0; i<Category.list_categories.length; i++){
      DatabaseHelper.db.insert_category(Category.list_categories[i]);
    }

    get_val();
  }

  void get_val() async{
    var _data = await DatabaseHelper.db.get_all_lesson();
    setState(() {
      all_lessons = (_data as List)
          .map((e) => Lesson.fromJson(e)).toList();

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('i-Study'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: (){},
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                  image: DecorationImage(
                    image: AssetImage('assets/category/mental.png')
                  ),
                ),

                child:Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
//                      CircleAvatar(
//                        radius: 50.0,
//                        backgroundImage: AssetImage('assets/category/mental.png'),
//                      ),
                    ],
                  ),
                )
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Contact'),
              onTap: (){

              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: (){

              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('i-Study',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 30
                  ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Choose your course ',
                  style: TextStyle(
                    color: Colors.grey
                  ),
                  ),
                  Text('right away',
                  style: TextStyle(
                    color: Colors.teal
                  ),
                  )
                ],
              ),
              SizedBox(height: 25,),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search for your training type...',
                          prefixIcon: Icon(Icons.search),
                          fillColor: Colors.grey[200],
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.grey[200])
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[200]),
                            borderRadius: BorderRadius.circular(10.0)
                          )
                        ),
                        onTap: (){
                          showSearch(context: context, delegate: Search(listResult: all_lessons));
                        },
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25,),
              GridView.count(
                padding: EdgeInsets.only(top: 6),
                shrinkWrap: true,
                crossAxisCount: 3,
                children: <Widget>[
                  CategoryList(Colors.yellow, 'assets/category/chemistry.png', 'Chemistry', 1),
                  CategoryList(Colors.redAccent, 'assets/category/stats.png', 'Business', 2),
                  CategoryList(Colors.lightBlueAccent, 'assets/category/it.png', 'IT & Software', 3),
                  CategoryList(Colors.lightGreen, 'assets/category/language.png', 'English', 4),
                  CategoryList(Colors.teal, 'assets/category/mental.png', 'Psychology', 5),
                  CategoryList(Colors.greenAccent, 'assets/category/mathematics.png', 'Mathematics', 6)
                ],
                ),
              Row(
                children: <Widget>[
                  Text('Recommented course',
                    style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('you may also like',
                    style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              FutureBuilder(
                future: callAsyncLesson(),
                builder: (context, AsyncSnapshot<Widget> snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data;
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),

    );
  }

  Future<Widget> callAsyncLesson(){
    return Future.delayed(Duration(seconds: 2),
        () => Container(
          height: 260,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: all_lessons.length,
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
                          builder: (context) => LessonDetailPage(lesson_id: all_lessons[index].id,)
                      ));
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color.fromARGB(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), Random().nextInt(256)),
                          ),
                          child: Column(
                            children: <Widget>[
                              Image.asset(all_lessons[index].image, width: 180, height: 90,)
                            ],
                          ),
                        ),
                        Container(
                          width: 160,
                          child: Column(
                            children: <Widget>[
                              Text(all_lessons[index].title,
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
                                  Text('${all_lessons[index].week} weeks',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12
                                    ),),
                                  SizedBox(width: 4,),
                                  Icon(Icons.access_time, size: 14,),
                                  Text('${all_lessons[index].hour} hrs per week',
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
          )
        )
    );
  }


  Widget CategoryList(Color clr, String image, String title, int category_id){

    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=> CategoryPage(category_id: category_id,)
        ));
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: clr,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 3,
                        spreadRadius: 4
                    )
                  ],
                  image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.fill
                  )
              ),
              height: 75,
              width: 75,
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}

