import 'package:flutter/material.dart';
import 'package:quarentine_schedule/pages/subject.dart';

class TaskCard extends StatelessWidget {
  final Map subject;
  final int index;

  TaskCard({@required this.subject,@required this.index});
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < subject['tasks'].length; i++){
      if(subject['tasks'][i]!=null){
        return InkWell(
          onTap: (){
             Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Subject(
                    title: subject['title'],
                    color: new Color(int.parse(subject['color'])),
                    videoURL: subject['videoURL'],
                    classURL: subject['classURL'],
                    tasks: subject['tasks'],
                    index: index
                    )),
          );
          },
                  child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      height: 75.0 * (subject['tasks'].length+1),
      child: Card(
            color: new Color(int.parse(subject['color'])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                for (int i = 0; i < subject['tasks'].length; i++)
                  ListTile(
                    title: Text(subject['tasks'][i],style: TextStyle(color:Colors.white),),
                    leading: Icon(Icons.check_box_outline_blank),
                  )
              ],
            )),
    ),
        );
      }
    }
  return Container();
    
    
  }
}
