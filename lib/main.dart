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
        title: Row(
          children: [
            Icon(Icons.check_circle_rounded),
            Text(
              'Pomodoro',
            ),
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                pomodoroState == 'pomodoro'
                    ? Colors.red.shade200
                    : pomodoroState == 'short break'
                        ? Colors.teal.shade200
                        : Colors.indigo.shade300,
              )),
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.insert_chart_outlined_rounded),
                  Text('Report'),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                pomodoroState == 'pomodoro'
                    ? Colors.red.shade200
                    : pomodoroState == 'short break'
                        ? Colors.teal.shade200
                        : Colors.indigo.shade300,
              )),
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.settings),
                  Text('Settings'),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                pomodoroState == 'pomodoro'
                    ? Colors.red.shade200
                    : pomodoroState == 'short break'
                        ? Colors.teal.shade200
                        : Colors.indigo.shade300,
              )),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.supervised_user_circle),
                  Text('Login'),
                ],
              ),
            ),
          ),
        ],
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
