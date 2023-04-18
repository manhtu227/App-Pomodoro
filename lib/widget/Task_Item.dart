import 'package:flutter/material.dart';
import '../models/TaskModel.dart';
import './FormAdd.dart';
import '../providers/Tasks.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatefulWidget {
  final TaskModel taskModel;
  const TaskItem({Key? key, required this.taskModel});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool checkEdit = false;
  bool showForm = false;

  void handleForm() {
    setState(() {
      showForm = !showForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              Provider.of<Tasks>(context, listen: false)
                  .selectTask(widget.taskModel.id)
            },
        child: !showForm
            ? Card(
                // margin: EdgeInsets.only(top: 10),

                child: Container(
                  width: double.infinity,
                  decoration: Provider.of<Tasks>(context).selectedTaskId ==
                          widget.taskModel.id
                      ? const BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Color.fromRGBO(34, 34, 34, 1),
                              width: 6,
                            ),
                          ),
                        )
                      : null,
                  padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => {
                              Provider.of<Tasks>(context, listen: false)
                                  .updateCheck(widget.taskModel.id)
                            },
                            child: Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                color: !widget.taskModel.check
                                    ? Color(0xFFDFDFDF)
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(11),
                                border: Border.all(
                                  color: !widget.taskModel.check
                                      ? Color(0xFFDFDFDF)
                                      : Colors.red,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            child: Text(
                              widget.taskModel.title,
                              overflow: TextOverflow.ellipsis,
                              style: !widget.taskModel.check
                                  ? const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF555555),
                                      fontSize: 16,
                                    )
                                  : const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 16,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor:
                                          Color.fromARGB(0, 0, 0, 0),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 18),
                            child: Text(
                              '${widget.taskModel.inputNumber1}/${widget.taskModel.inputNumber}',
                              style: const TextStyle(
                                color: Color(0xFFBBBBBB),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: handleForm,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Color(0xFFDFDFDF),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.more_vert,
                                size: 18,
                                color: Color(0xFFAAAAAA),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : FormAdd(handleForm, widget.taskModel.id, false));
  }
}
