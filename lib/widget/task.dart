import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
// This is the type used by the popup menu below.
import './optionTask.dart';
import 'FormAdd.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
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
          !showForm
              ? Container(
                  width: double.infinity,
                  height: 57,
                  // decoration: BoxDecoration(),
                  color: Colors.white.withOpacity(0.1),
                  child: DottedBorder(
                      color: Colors.white, //color of dotted/dash line
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
                            mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
