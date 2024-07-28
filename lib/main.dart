
import 'package:flutter/material.dart';
import 'package:lodge/login_page.dart';
import 'package:lodge/screen/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(Object context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
       theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 228, 225, 235),
        primaryColor:  Color(0x0087ceeb),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary:  Color.fromARGB(248, 14, 14, 14),
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            color:Color.fromARGB(255, 99, 99, 102),),
          bodyLarge: TextStyle(
            color: Colors.blue.withOpacity(0.5)),
          ), 
       ),
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
      },
      );
      
  }
}