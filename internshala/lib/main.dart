import 'package:flutter/material.dart';
import 'package:internshala/welcome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
@override
Widget build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: WelcomeScreen(),
  );
}
}



