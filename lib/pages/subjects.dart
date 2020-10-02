import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quarentine_schedule/pages/new_subject.dart';
import 'package:quarentine_schedule/provider/app_state.dart';
import 'package:quarentine_schedule/widgets/my_card.dart';
import 'package:quarentine_schedule/widgets/my_drawer.dart';

class Subjects extends StatefulWidget {
  @override
  _SubjectsState createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text('Todas tus clases')),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
                children: appState.subjects
                    .asMap()
                    .map((index, subject) => MapEntry(
                        index,
                        MyCard(
                            color: new Color(int.parse(subject['color'])),
                            title: '${subject['title']}',
                            profesor: '${subject['profesor']}',
                            videoURL: '${subject['videoURL']}',
                            classURL: '${subject['classURL']}',
                            tasks: subject['tasks'],
                            index: appState.subjects.indexOf(subject))))
                    .values
                    .toList()),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewSubject()),
          );
        },
      ),
    );
  }
}
