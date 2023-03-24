import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
// This is the type used by the popup menu below.
import './newTask.dart';

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
          Text("#0"),
          Text("Time to focus"),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tasks"),
                Card(
                  color: Colors.white.withOpacity(0.1),
                  child: PopupMenuButton(
                    icon: Icon(Icons.more_vert, color: Colors.white),
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        child: Text('Clear finish task'),
                        value: 'Option 1',
                      ),
                      PopupMenuItem(
                        child: Text('Clear all task'),
                        value: 'Option 2',
                      ),
                      PopupMenuItem(
                        child: Text('Option 3'),
                        value: 'Option 3',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
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
                      child: new SizedBox(
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
              : MyForm(handleCancelForm)
        ],
      ),
    );
  }
}
