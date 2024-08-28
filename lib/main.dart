import 'package:flutter/material.dart';
import 'package:lodge/login_page.dart';
import 'package:lodge/screen/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lodge App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color.fromARGB(255, 246, 246, 248),
      ),
      home: LoginPage(),
      routes: {
        '/home': (context) {
          final Map<String, String> args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          return HomePage(role: args['role']!);
        },
      },
    );
  }
}
