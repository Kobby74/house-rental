import 'package:flutter/material.dart';
import 'package:lodge/login_page.dart';
import 'package:lodge/screen/home/add_apartment.dart';
import 'package:lodge/screen/home/home.dart';
import 'package:lodge/screen/home/widget/searchpage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lodge App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      home: const LoginPage(),
      routes: {
        '/home': (context) {
          final Map<String, String> args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          return HomePage(role: args['role']!, username: args['username']!,);
        },
        '/add_apartment': (context) => const AddApartment(),
        '/search':(context) => SearchPage(),
        
      },
    );
  }
}
