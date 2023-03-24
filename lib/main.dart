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

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String pomodoroState = 'pomodoro';

  setPomodoroSate(String state) {
    setState(() {
      pomodoroState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pomodoroState == 'pomodoro'
          ? Colors.red.shade300
          : pomodoroState == 'short break'
              ? Colors.teal.shade300
              : Colors.indigo.shade400,
      appBar: AppBar(
        title: Text(
          'Pomodoro',
        ),
        backgroundColor: pomodoroState == 'pomodoro'
            ? Colors.red.shade300
            : pomodoroState == 'short break'
                ? Colors.teal.shade300
                : Colors.indigo.shade400,
      ),
      body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CountdownTimerPomo(
                pomodoroState: pomodoroState,
                setPomodoroState: setPomodoroSate,
              ),
              // Tasks(),
            ],
          )),
    );
  }
}
