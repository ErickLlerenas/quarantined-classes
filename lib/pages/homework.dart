import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quarentine_schedule/provider/app_state.dart';
import 'package:quarentine_schedule/widgets/task_card.dart';

class HomeWork extends StatefulWidget {
  @override
  _HomeWorkState createState() => _HomeWorkState();
}

class _HomeWorkState extends State<HomeWork> {
  List<List> tasks = [];

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    tasks = [];
    appState.subjects.forEach((subject) => {
          setState(() {
            tasks.add(subject['tasks']);
            print(subject['tasks']);
          }),
        });
    print(tasks);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tareas pendientes'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
             children: appState.subjects.asMap().map((index,subject)=>MapEntry(index, TaskCard(subject: subject,index:index))).values.toList() 
           ),
        ),
      ),
    );
  }
}
