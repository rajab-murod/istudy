import 'package:flutter/material.dart';
import 'package:istudy/models/lesson_model.dart';
import 'package:istudy/views/lesson_detail.dart';

class Search extends SearchDelegate{
  final List<Lesson> listResult;
  
  Search({this.listResult});

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: (){
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    List<Lesson> suggestionList = [];
    query.isEmpty
    ? suggestionList = []
    : suggestionList.addAll(listResult.where((element) => element.title.toLowerCase().contains(query.toLowerCase()),));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index){
        return ListTile(
          title: Text(
            suggestionList[index].title,
          ),
          onTap: (){

            Navigator.push(context, MaterialPageRoute(
                builder: (context) => LessonDetailPage(lesson_id: suggestionList[index].id,)
            ));
          },
        );
      },
    );

  }
  
}