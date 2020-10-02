import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quarentine_schedule/pages/subject.dart';
import 'package:quarentine_schedule/provider/app_state.dart';

class MyCard extends StatelessWidget {
  final Color color;
  final String title;
  final String profesor;
  final String videoURL;
  final String classURL;
  final List <dynamic> tasks;
  final int index;

  MyCard(
      {@required this.color,
      @required this.title,
      @required this.profesor,
      @required this.videoURL,
      @required this.classURL,
      @required this.index,
      this.tasks,});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      height: 130,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Subject(
                    title: this.title,
                    color: this.color,
                    videoURL: this.videoURL,
                    classURL: this.classURL,
                    tasks: this.tasks,
                    index: this.index
                    )),
          );
        },
        onLongPress: (){
          appState.showDeleteDialog(this.index,context);
        },
        child: Card(
          color: this.color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text("${this.title}",
                    style: TextStyle(color: Colors.white, fontSize: 22,fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis),
              ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text("${this.profesor}",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    overflow: TextOverflow.ellipsis),
                  ),
                  
            ],
          ),
        ),
      ),
    );
  }
}
