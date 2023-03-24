import 'package:flutter/material.dart';
import 'dart:async';

class CountdownTimerPomo extends StatefulWidget {
  const CountdownTimerPomo({super.key});

  @override
  State<CountdownTimerPomo> createState() => _CountdownTimerPomoState();
}

class _CountdownTimerPomoState extends State<CountdownTimerPomo> {
  int countPomodoro = 0;
  bool pomodoroBreakState = false;
  bool countdownState = false;
  Duration duration = Duration(seconds: 25);
  Timer? countdownTimer;

  startTimer() {
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

  resetTimer() {
    stopTimer();
    setState(() {
      duration = Duration(minutes: 25);
    });
  }

  setCountdown() {
    setState(() {
      countdownState = true;
      final second = duration.inSeconds - 1;
      if (second < 0) {
        countdownState = false;
        countdownTimer!.cancel();
        if (pomodoroBreakState == false) {
          pomodoroBreakState = true;
          countPomodoro += 1;
          if (countPomodoro % 4 == 0)
            duration = Duration(seconds: 15);
          else
            duration = Duration(seconds: 5);
        } else {
          pomodoroBreakState = false;
          duration = Duration(seconds: 25);
        }
      } else {
        duration = Duration(seconds: second);
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
                color: Colors.red.shade400,
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => {},
                      child: Text(
                        'Pomodoro',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: pomodoroBreakState
                          ? null
                          : ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.blue)),
                    ),
                    TextButton(
                      onPressed: () => {},
                      child: Text(
                        'Short break',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: (pomodoroBreakState && countPomodoro % 4 != 0)
                          ? ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.blue))
                          : null,
                    ),
                    TextButton(
                      onPressed: () => {},
                      child: Text(
                        'Long break',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: (pomodoroBreakState && countPomodoro % 4 == 0)
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
                                'Stop',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.red,
                                ),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white)),
                            )
                          : ElevatedButton(
                              onPressed: startTimer,
                              child: Text(
                                'Start',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.red,
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
                            onPressed: () => {},
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
          pomodoroBreakState ? Text("Time for a break") : Text('Time to focus'),
        ],
      ),
    );
  }
}
