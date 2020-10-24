import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quarentine_schedule/provider/app_state.dart';
import 'package:quarentine_schedule/widgets/daily_card.dart';
import 'package:quarentine_schedule/widgets/my_drawer.dart';

class Today extends StatefulWidget {
  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  List<List> days;
  String day;

  @override
  void initState() {
    switch (DateTime.now().weekday) {
      case 1:
        day = "lunes";
        break;
      case 2:
        day = "martes";
        break;
      case 3:
        day = "miércoles";
        break;
      case 4:
        day = "jueves";
        break;
      case 5:
        day = "viernes";
        break;
      case 6:
        day = "sábado";
        break;
      default:
        day = "domingo";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    days = [];
    appState.subjects.forEach((subject) => {
          setState(() {
            days.add(subject['days']);
            print(subject['days']);
          }),
        });
    print(days);
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Clases en $day'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
              children: appState.subjects
                  .asMap()
                  .map((index, subject) => MapEntry(
                      index, DailyCard(subject: subject, index: index)))
                  .values
                  .toList()),
        ),
      ),
    );
  }
}
