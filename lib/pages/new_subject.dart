import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:quarentine_schedule/provider/app_state.dart';
import 'package:weekday_selector/weekday_selector.dart';

class NewSubject extends StatefulWidget {
  @override
  _NewSubjectState createState() => _NewSubjectState();
}

class _NewSubjectState extends State<NewSubject> {
  final values = List.filled(7, false);

  Color pickerColor = Colors.blue;
  Color currentColor = Colors.blue;

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController videoURLController = TextEditingController();
  TextEditingController classURLController = TextEditingController();
  TextEditingController profesorController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    videoURLController.dispose();
    classURLController.dispose();
    profesorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: pickerColor,
        child: Icon(Icons.color_lens),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Escoge un color'),
                content: SingleChildScrollView(
                  child: BlockPicker(
                    pickerColor: currentColor,
                    onColorChanged: changeColor,
                  ),
                ),
              );
            },
          );
        },
      ),
      appBar: AppBar(
        title: Text('Nueva clase'),
        backgroundColor: pickerColor,
      ),
      body: SingleChildScrollView(
          child: Form(
              child: Column(children: <Widget>[
        TextFormField(
          controller: titleController,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20.0),
              labelText: 'Ingresa el nombre de la clase'),
        ),
        TextFormField(
          controller: profesorController,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20.0),
              labelText: 'Ingresa el nombre del profesor'),
        ),
        TextFormField(
          controller: videoURLController,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20.0),
              labelText: 'Ingresa URL de la video llamada'),
        ),
        TextFormField(
          controller: classURLController,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20.0),
              labelText: 'Ingresa URL de la plataforma de clases'),
        ),
        Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Text('Selecciona los días de la semana:'),
              WeekdaySelector(
                selectedFillColor: pickerColor,
                onChanged: (int day) {
                  setState(() {
                    final index = day % 7;
                    values[index] = !values[index];
                  });
                },
                values: values,
              ),
            ],
          ),
        ),
        FlatButton(
          color: pickerColor,
          child: Text('Crear clase',style: TextStyle(color: Colors.white),),
          onPressed: () {
            print('${classURLController.text}');
            print('${videoURLController.text}');
            print('${titleController.text}');
            print('${profesorController.text}');
            print(pickerColor);
            appState.addSubject({
              'color':pickerColor.value.toString(),
              'title': titleController.text,
              'videoURL':videoURLController.text,
              'classURL': classURLController.text,
              'profesor':profesorController.text
            });
          },
        )
      ]))),
    );
  }
}
