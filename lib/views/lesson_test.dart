import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:istudy/db/database_helpers.dart';
import 'package:istudy/models/test_model.dart';

class LessonTest extends StatefulWidget {
  final int lesson_id;
  LessonTest({@required this.lesson_id});
  @override
  _LessonTestState createState() => _LessonTestState();
}

class _LessonTestState extends State<LessonTest> {
  List<Test> test_list;
  List<Variant> variant_list;
  int selectedVariant = 1;
  int index;
  bool next = false;
  bool prev;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    // add question to db
    for(var i=0; i<Test.test_lists.length; i++){
      DatabaseHelper.db.insert_test(Test.test_lists[i]);
    }

    // add variant of question to db
    for(var i=0; i<Variant.variant_lists.length; i++){
      DatabaseHelper.db.insert_variant(Variant.variant_lists[i]);
    }
    get_val();
  }
  void get_val() async{
    var _data = await DatabaseHelper.db.get_test(widget.lesson_id);
    setState(() {
      test_list = (_data as List).map((e) => Test.fromJson(e)).toList();
      index = test_list[0].id;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
        centerTitle: true,
//        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            children: next ? TestBody(1): TestBody(0),
          )
        ),
      ),
    );
  }

  void get_variant(int test_id) async{
    var _data = await DatabaseHelper.db.get_variant(test_id);
    setState(() {
      variant_list = (_data as List)
          .map((e) => Variant.fromJson(e)).toList();
    });
  }

  setSelectedVariant(int variant){
    setState(() {
      selectedVariant = variant;
    });
  }

  List<Widget> TestBody(int index){
    List<Widget> widgets = [Text('${test_list[index].question}?'), ];

    get_variant(test_list[index].id);

//    print(variant_list.length);

    for(Variant variant in variant_list){
      widgets.add(
        ListTile(
          title: Text(variant.variant_text),
          leading: Radio(
            value: variant.id,
            groupValue: selectedVariant,
            onChanged: (current_variant){
              setSelectedVariant(current_variant);
              print(current_variant);
              print(selectedVariant);
            },

          ),
        )
//        RadioListTile(
//          value: variant.id,
//          groupValue: selectedVariant,
//          title: Text(variant.variant_text),
//          onChanged: (currentVariant){
//            print(currentVariant);
//            setSelectedVariant(currentVariant);
//            print(selectedVariant);
//          },
//          selected: selectedVariant == variant.id,
//          activeColor: Colors.blueGrey,
//        )
      );
    }
    widgets.add(
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                child: Icon(Icons.chevron_left),
                onPressed: (){
                  next = false;
                },
              ),
              SizedBox(width: 100,),

              FloatingActionButton(
                child: Icon(Icons.chevron_right),
                onPressed: (){
                  setState(() {
                    next = true;
                    index = test_list[1].id;
                  });
                },
              )
            ],
          )),
        );
    return widgets;
  }

   Future<Widget> callAsyncTest() {
    return Future.delayed(Duration(seconds: 1),
        () => Column(
          children: next ? TestBody(1): TestBody(0),
        )
    );
   }
}
