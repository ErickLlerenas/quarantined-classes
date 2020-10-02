import 'package:flutter/material.dart';
import 'package:quarentine_schedule/pages/homework.dart';
import 'package:quarentine_schedule/pages/subjects.dart';
import 'package:quarentine_schedule/pages/today.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   int _selectedIndex = 0;
  
  static List<Widget> _widgetOptions = <Widget>[
    Subjects(),
    Today(),
    HomeWork()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Clases'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            title: Text('Hoy'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Tareas'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}