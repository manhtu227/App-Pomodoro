import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/Task_Item.dart';
import 'package:provider/provider.dart';
import '../providers/Tasks.dart';
import '../models/TaskModel.dart';

class TasksList extends StatelessWidget {
  // const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    final tasksData = Provider.of<Tasks>(context);
    if (tasksData == null || tasksData.items == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    // print(tasksData.items);
    // print("tasksData helloaosdoasdasd");
    return Column(
        children: tasksData.items.map((task) {
      return TaskItem( key: Key('task_${task.id}'),taskModel: task);
    }).toList()
        // ListView.builder(
        //   itemCount: tasksData.items.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     return TaskItem(taskModel: tasksData.items[index]);
        //   },
        // ),
        );
  }
}
