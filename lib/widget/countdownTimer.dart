import 'package:flutter/material.dart';
import 'dart:async';
import '../providers/Tasks.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class CountdownTimerPomo extends StatefulWidget {
  String pomodoroState;
  Function setPomodoroState;
  CountdownTimerPomo(
      {required this.pomodoroState, required this.setPomodoroState});

  @override
  State<CountdownTimerPomo> createState() => _CountdownTimerPomoState();
}

class _CountdownTimerPomoState extends State<CountdownTimerPomo> {
  int countPomodoro = 0;
  bool countdownState = false;
  Duration duration = Duration(seconds: 10);
  Timer? countdownTimer;
  double width = 0;
  int check = 10;
  startTimer() {
    setCountdown();
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setCountdown();
    });
  }

  stopTimer() {
    setState(() {
      countdownState = false;
      countdownTimer!.cancel();
    });
  }

  nextTimer() {
    setState(() {
      width = 0;
      countdownState = false;
      countdownTimer!.cancel();
      if (widget.pomodoroState == 'pomodoro') {
        countPomodoro += 1;
        Provider.of<Tasks>(context, listen: false).updateInputNumber1();
        if (countPomodoro % 4 == 0) {
          widget.setPomodoroState('long break');
          duration = Duration(seconds: 15);
          check = 15;
        } else {
          widget.setPomodoroState('short break');
          duration = Duration(seconds: 5);
          check = 5;
        }
      } else {
        widget.setPomodoroState('pomodoro');
        duration = Duration(seconds: 10);
        check = 10;
      }
    });
  }

  setCountdown() {
    setState(() {
      countdownState = true;
      final second = duration.inSeconds - 1;
      width = 1 - second / check;
      if (second < 0) {
        width = 0;

        countdownState = false;
        countdownTimer!.cancel();
        if (widget.pomodoroState == 'pomodoro') {
          countPomodoro += 1;
          Provider.of<Tasks>(context, listen: false).updateInputNumber1();

          if (countPomodoro % 4 == 0) {
            widget.setPomodoroState('long break');
            duration = Duration(seconds: 15);
            check = 15;
          } else {
            widget.setPomodoroState('short break');
            duration = Duration(seconds: 5);
            check = 5;
          }
        } else {
          widget.setPomodoroState('pomodoro');
          duration = Duration(seconds: 10);
          check = 10;
        }
      } else {
        duration = Duration(seconds: second);
      }
    });
  }

  changeState(String state) {
    setState(() {
      if (countdownTimer != null) countdownTimer!.cancel();
      countdownState = false;
      switch (state) {
        case 'pomodoro':
          widget.setPomodoroState('pomodoro');
          duration = Duration(seconds: 10);
          break;
        case 'short break':
          widget.setPomodoroState('short break');
          duration = Duration(seconds: 5);
          break;
        case 'long break':
          widget.setPomodoroState('long break');
          duration = Duration(seconds: 15);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(duration.inMinutes.remainder(60));
    final seconds = strDigits(duration.inSeconds.remainder(60));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FractionallySizedBox(
          widthFactor: width,
          child: Container(
            height: 3,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                // width: 350,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => {changeState('pomodoro')},
                          style: widget.pomodoroState == 'pomodoro'
                              ? ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.black.withOpacity(0.15)))
                              : null,
                          child: const Text(
                            'Pomodoro',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () => {changeState('short break')},
                          style: (widget.pomodoroState == 'short break')
                              ? ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.black.withOpacity(0.15)))
                              : null,
                          child: const Text(
                            'Short break',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () => {changeState('long break')},
                          child: Text(
                            'Long break',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: (widget.pomodoroState == 'long break')
                              ? ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.black.withOpacity(0.15)))
                              : null,
                        ),
                      ],
                    ),
                    Text(
                      '$minutes:$seconds',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 100),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 40),
                        Container(
                          width: 150,
                          height: 45,
                          child: countdownState
                              ? ElevatedButton(
                                  onPressed: () {
                                    if (countdownTimer == null ||
                                        countdownTimer!.isActive) {
                                      stopTimer();
                                    }
                                  },
                                  child: Text(
                                    'STOP',
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: widget.pomodoroState == 'pomodoro'
                                          ? Colors.red.shade300
                                          : widget.pomodoroState ==
                                                  'short break'
                                              ? Colors.teal.shade300
                                              : Colors.indigo.shade400,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.white)),
                                )
                              : ElevatedButton(
                                  onPressed: startTimer,
                                  child: Text(
                                    'START',
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: widget.pomodoroState == 'pomodoro'
                                          ? Colors.red.shade300
                                          : widget.pomodoroState ==
                                                  'short break'
                                              ? Colors.teal.shade300
                                              : Colors.indigo.shade400,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.white)),
                                ),
                        ),
                        !countdownState
                            ? SizedBox(width: 40)
                            : IconButton(
                                onPressed: () => {nextTimer()},
                                icon: Icon(
                                  Icons.skip_next,
                                  color: Colors.white,
                                )),
                      ],
                    ),
                  ],
                ),
              ),
              Text("#${countPomodoro}"),
              Provider.of<Tasks>(context).selectedTaskId != "khong"
                  ? Text(Provider.of<Tasks>(context, listen: false).getTitle())
                  : widget.pomodoroState == 'pomodoro'
                      ? Text("Time to focus")
                      : Text('Time for a break'),
            ],
          ),
        ),
      ],
    );
  }
}
