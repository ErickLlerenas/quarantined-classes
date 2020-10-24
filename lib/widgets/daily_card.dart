import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quarentine_schedule/pages/subject.dart';
import 'package:quarentine_schedule/provider/app_state.dart';

class DailyCard extends StatelessWidget {
  final Map subject;
  final int index;

  DailyCard({@required this.subject, @required this.index});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
        for (int i = 0; i < subject['days'].length; i++){
                
                  if(subject['days'][DateTime.now().weekday]){
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
                    title: subject['title'],
                    color: new Color(int.parse(subject['color'])),
                    videoURL: subject['videoURL'],
                    classURL: subject['classURL'],
                    tasks: subject['tasks'],
                    index: subject['index'])),
          );
        },
        onLongPress: () {
          appState.showDeleteDialog(this.index, context);
        },
        child: Card(
          color: new Color(int.parse(subject['color'])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text("${subject['title']}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text("${subject['profesor']}",
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
  return Container();
        
  }
}
