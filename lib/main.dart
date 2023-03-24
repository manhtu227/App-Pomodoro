import 'package:flutter/material.dart';
import './widget/task.dart';
import './widget/countdownTimer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        title: Text(
          'Pomodoro',
        ),
      ),
      body: Container(
          child: Column(
        children: [
          CountdownTimerPomo(),
          Tasks(),
        ],
      )),
    );
  }
}
