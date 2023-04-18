import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/Task_Item.dart';
import 'package:flutter_application_1/widget/Task_List.dart';
import '../widget/task.dart';
import '../widget/countdownTimer.dart';
import '../widget/FormAdd.dart';
import '../widget/optionTask.dart';
import 'package:dotted_border/dotted_border.dart';

class PomodoroScreen extends StatefulWidget {
  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  String pomodoroState = 'pomodoro';
  bool showForm = false;
  void handleShowForm() {
    setState(() {
      showForm = true;
    });
  }

  void handleCancelForm() {
    setState(() {
      showForm = false;
    });
  }

  setPomodoroSate(String state) {
    setState(() {
      pomodoroState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: pomodoroState == 'pomodoro'
              ? Color(0xFFBA4949)
              : pomodoroState == 'short break'
                  ? Color(0xFF38858a)
                  : Color(0xFF397097),
          appBar: AppBar(
            title: const Text(
              'Pomodoro',
            ),
            backgroundColor: pomodoroState == 'pomodoro'
                ? const Color(0xFFBA4949)
                : pomodoroState == 'short break'
                    ? const Color(0xFF38858a)
                    : const Color(0xFF397097),
          ),
          body: SingleChildScrollView(
            child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CountdownTimerPomo(
                      pomodoroState: pomodoroState,
                      setPomodoroState: setPomodoroSate,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          optionTask(),
                          const SizedBox(
                            height: 10,
                          ),
                          TasksList(),
                          const SizedBox(
                            height: 10,
                          ),
                          !showForm
                              ? Container(
                                  width: double.infinity,
                                  height: 57,
                                  // decoration: BoxDecoration(),
                                  color: Colors.white.withOpacity(0.1),
                                  child: DottedBorder(
                                      color: Colors
                                          .white, //color of dotted/dash line
                                      strokeWidth: 1, //thickness of dash/dots
                                      dashPattern: [5, 2],
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 57,
                                        child: OutlinedButton(
                                          style: TextButton.styleFrom(
                                              foregroundColor: Colors.white),
                                          onPressed: handleShowForm,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.add),
                                              SizedBox(
                                                  width:
                                                      5), // Khoảng cách giữa biểu tượng và nút
                                              Text('Add Task'),
                                            ],
                                          ),
                                        ),
                                      )),
                                )
                              : FormAdd(handleCancelForm, null, true)
                        ],
                      ),
                    )
                  ],
                )),
          )),
    );
  }
}
