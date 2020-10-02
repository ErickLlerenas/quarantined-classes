import 'package:flutter/material.dart';

class Today extends StatefulWidget {

  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {

  String day;

  @override
  void initState(){
    switch(DateTime.now().weekday){
      case 1: day =  "lunes";
      break;
      case 2: day =  "martes";
      break;
      case 3: day =  "miércoles";
      break;
      case 4: day =  "jueves";
      break;
      case 5: day =  "viernes";
      break;
      case 6: day =  "sábado";
      break;
      default: day = "domingo";
    }
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clases en $day'),),
      body: Center(),
    );
  }
}
