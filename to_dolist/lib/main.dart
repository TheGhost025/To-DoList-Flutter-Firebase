import 'package:flutter/material.dart';
import 'package:to_dolist/logIn.dart';
import 'package:to_dolist/signup.dart';
import 'package:to_dolist/todolist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.blue),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LogInPage(),
        '/signup': (context) => SignUpPage(),
        '/todolist': (context) => ToDoListPage(),
      },
    );
  }
}
