import 'package:flutter/material.dart';
import './screens/pomodoro_screen.dart';
import 'package:provider/provider.dart';
import './providers/Tasks.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => Tasks(),
        child: MaterialApp(
          title: 'Pomodoro',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            textTheme:
                const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
            accentColor: Colors.amber,
            fontFamily: 'Quicksand',
          ),
          home: PomodoroScreen(),
        ));
  }
}
