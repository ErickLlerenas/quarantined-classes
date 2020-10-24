import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AppState with ChangeNotifier {
  List subjects = [
    // {
    //   'color': '4284514675',
    //   'title': 'Dirección de proyectos de Software',
    //   'profesor': 'Aguilar Arias Angélica María',
    //   'videoURL': 'https://meet.google.com/lookup/hywy4mowxw',
    //   'classURL': 'https://classroom.google.com/h',
    //   'tasks': [],
    //   'days': [false, true, false, false, true, false, false]
    // },
    // {
    //   'color': '4294940672',
    //   'title': 'Programación para móviles',
    //   'profesor': 'Gallardo Armando Román',
    //   'videoURL': 'https://meet.google.com/nrt-hmcp-evw',
    //   'classURL': 'http://telematicanet.ucol.mx/moodle/',
    //   'tasks': [],
    //   'days': [false, true, false, true, false, false, false]
    // },
    // {
    //   'color': '4293467747',
    //   'title': 'Gestión de las tecnologías de la información',
    //   'profesor': 'Nava Bautista Martha Xóchitl',
    //   'videoURL':
    //       'https://us04web.zoom.us/j/9040707159?pwd=b3RRNzVMN29Lc3VaL0VQNlVmU3NFQT09',
    //   'classURL': 'http://telematicanet.ucol.mx/moodle/',
    //   'tasks': [],
    //   'days': [false, false, false, true, false, true, false]
    // },
    // {
    //   'color': '4283215696',
    //   'title': 'Inglés V',
    //   'profesor': 'Ávalos Díaz Julia Karina',
    //   'videoURL': 'https://meet.google.com/lookup/a4kwap4xnt',
    //   'classURL': 'https://classroom.google.com/h',
    //   'tasks': [],
    //   'days': [false, false, false, true, false, true, false]
    // },
    // {
    //   'color': '4294198070',
    //   'title': 'Interacción humano computadora',
    //   'profesor': 'Santana Mancilla Pedro César',
    //   'videoURL': 'https://meet.google.com/lookup/b3b6qynsmz',
    //   'classURL': 'https://classroom.google.com/h',
    //   'tasks': ['Crear un video sobre los malos diseños'],
    //   'days': [false, false, true, false, true, false, false]
    // },
    // {
    //   'color': '4280391411',
    //   'title': 'Investigación de operaciones y simulación',
    //   'profesor': 'Montesinos López Osval Antonio',
    //   'videoURL': 'https://meet.google.com/gyh-vtgg-mbv',
    //   'classURL': 'https://classroom.google.com/h',
    //   'tasks': [],
    //   'days': [false, false, true, false, true, false, false]
    // },
    // {
    //   'color': '4288423856',
    //   'title': 'Programación de videojuegos',
    //   'profesor': 'Lepe Salazar Francisco Ivan',
    //   'videoURL': 'https://meet.google.com/lookup/eyifecgwc5',
    //   'classURL': 'https://classroom.google.com/h',
    //   'tasks': [],
    //   'days': [false, true, false, true, false, true, false]
    // }
  ];

  TextEditingController newTaskController = TextEditingController();
  AppState() {
    // writeSubjects(subjects);
    readSubjects();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/subjects.txt');
  }

  Future<File> writeSubjects(List subjects) async {
    final file = await _localFile;
    String conversion = jsonEncode(subjects);
    return file.writeAsString('$conversion');
  }

  void readSubjects() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      List conversion = jsonDecode(contents);
      subjects = conversion;
      notifyListeners();
      print(subjects);
    } catch (e) {
      print(e);
    }
  }

  void addSubject(subject) {
    subjects.add(subject);
    notifyListeners();
    writeSubjects(subjects);
  }

  void deleteSubject(index) {
    subjects.removeAt(index);
    writeSubjects(subjects);
    notifyListeners();
  }

  void addTaskToSubject(int index, String subject) {
    subjects.elementAt(index)['tasks'].add(subject);
    newTaskController.text = "";
    writeSubjects(subjects);
    notifyListeners();
  }

  void addTaskToSubjectDialog(context, index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "Nueva tarea:",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
          content: Container(
            height: 130,
            child: Column(
              children: [
                TextFormField(
                  controller: newTaskController,
                ),
                SizedBox(height: 20),
                FlatButton(
                    color: new Color(
                        int.parse(subjects.elementAt(index)['color'])),
                    child: Text(
                      'Agregar',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      addTaskToSubject(index, newTaskController.text);
                    })
              ],
            ),
          ),
          actions: <Widget>[],
        );
      },
    );
  }

  void completeTask(int taskIndex, int index) {
    subjects.elementAt(index)['tasks'].removeAt(taskIndex);
    writeSubjects(subjects);
    notifyListeners();
  }

  void showDeleteDialog(index, context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "¿Eliminar clase?",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
          content: Container(
            height: 130,
            child: Column(
              children: [
                Text(
                  "Se va a borrar esta clase y ya no podrás recuperarla. Tendrás que volverla a crear.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                SizedBox(height: 20),
                FlatButton(
                    color: Colors.red[700],
                    child: Text(
                      'Eliminar',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      deleteSubject(index);
                    })
              ],
            ),
          ),
          actions: <Widget>[],
        );
      },
    );
  }
}
