import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quarentine_schedule/provider/app_state.dart';
import 'package:url_launcher/url_launcher.dart';

class Subject extends StatelessWidget {
  final Color color;
  final String title;
  final String videoURL;
  final String classURL;
  final List tasks;
  final int index;

  Subject(
      {@required this.color,
      @required this.title,
      @required this.videoURL,
      @required this.classURL,
      @required this.index,
      this.tasks});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            appState.addTaskToSubjectDialog(context,index);
          },
          backgroundColor: this.color,
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('${this.title}'),
          backgroundColor: this.color,
          actions: [
            PopupMenuButton<String>(
              onSelected: choiceAction,
              itemBuilder: (BuildContext context) {
                return Constants.choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: ListView(
            children: this
                .tasks
                .asMap()
                .map((taskIndex, task) => MapEntry(
                    taskIndex,
                    ListTile(
                      title: Text('$task'),
                      leading: IconButton(
                        icon: Icon(Icons.check_box_outline_blank),
                        onPressed: () {
                          appState.completeTask(taskIndex,index);
                        },
                      ),
                    )))
                .values
                .toList()));
  }

  void choiceAction(String choice) {
    if (choice == Constants.VideoURL) {
      _launchURL(this.videoURL);
    } else {
      _launchURL(this.classURL);
    }
  }

  void _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}

class Constants {
  static const String VideoURL = 'Ir a la video llamada';
  static const String ClassURL = 'Ir a la clase';

  static const List<String> choices = <String>[
    VideoURL,
    ClassURL,
  ];
}
