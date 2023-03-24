import 'package:flutter/material.dart';
import 'dart:async';

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
  Duration duration = Duration(seconds: 25);
  Timer? countdownTimer;

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
      countdownState = false;
      countdownTimer!.cancel();
      if (widget.pomodoroState == 'pomodoro') {
        countPomodoro += 1;
        if (countPomodoro % 4 == 0) {
          widget.setPomodoroState('long break');
          duration = Duration(seconds: 15);
        } else {
          widget.setPomodoroState('short break');
          duration = Duration(seconds: 5);
        }
      } else {
        widget.setPomodoroState('pomodoro');
        duration = Duration(seconds: 25);
      }
    });
  }

  setCountdown() {
    setState(() {
      countdownState = true;
      final second = duration.inSeconds - 1;
      if (second < 0) {
        countdownState = false;
        countdownTimer!.cancel();
        if (widget.pomodoroState == 'pomodoro') {
          countPomodoro += 1;
          if (countPomodoro % 4 == 0) {
            widget.setPomodoroState('long break');
            duration = Duration(seconds: 15);
          } else {
            widget.setPomodoroState('short break');
            duration = Duration(seconds: 5);
          }
        } else {
          widget.setPomodoroState('pomodoro');
          duration = Duration(seconds: 25);
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
          duration = Duration(seconds: 25);
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
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            width: 350,
            decoration: BoxDecoration(
                color: widget.pomodoroState == 'pomodoro'
                    ? Colors.red.shade200
                    : widget.pomodoroState == 'short break'
                        ? Colors.teal.shade200
                        : Colors.indigo.shade300,
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => {changeState('pomodoro')},
                      child: Text(
                        'Pomodoro',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: widget.pomodoroState == 'pomodoro'
                          ? ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.blue))
                          : null,
                    ),
                    TextButton(
                      onPressed: () => {changeState('short break')},
                      child: Text(
                        'Short break',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: (widget.pomodoroState == 'short break')
                          ? ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.blue))
                          : null,
                    ),
                    TextButton(
                      onPressed: () => {changeState('long break')},
                      child: Text(
                        'Long break',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: (widget.pomodoroState == 'long break')
                          ? ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.blue))
                          : null,
                    ),
                  ],
                ),
                Text(
                  '$minutes:$seconds',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 100),
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
                                      : widget.pomodoroState == 'short break'
                                          ? Colors.teal.shade300
                                          : Colors.indigo.shade400,
                                ),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white)),
                            )
                          : ElevatedButton(
                              onPressed: startTimer,
                              child: Text(
                                'START',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: widget.pomodoroState == 'pomodoro'
                                      ? Colors.red.shade300
                                      : widget.pomodoroState == 'short break'
                                          ? Colors.teal.shade300
                                          : Colors.indigo.shade400,
                                ),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white)),
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
          widget.pomodoroState == 'pomodoro'
              ? Text("Time to focus")
              : Text('Time for a break'),
        ],
      ),
    );
  }
}
