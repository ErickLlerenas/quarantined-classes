import 'package:flutter/material.dart';
import 'package:quarentine_schedule/home.dart';
import 'package:provider/provider.dart';
import 'package:quarentine_schedule/provider/app_state.dart';

void main(){
    WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home()
    );
  }
}