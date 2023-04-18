import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/TaskModel.dart';
import '../providers/Tasks.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class FormAdd extends StatefulWidget {
  final Function handleCancelForm;
  final String? id;
  final bool checkAdd;
  FormAdd(this.handleCancelForm, this.id, this.checkAdd);
  @override
  _FormAddState createState() => _FormAddState();
}

class _FormAddState extends State<FormAdd> {
  bool showNote = false;
  int inputNumber = 0;
  int inputNumber1 = 0;
  String? title;
  String? note;
  bool check = false;
  // var _isInit = true;
  // var _editedTask = TaskModel(
  //   id: null!,
  //   title: '',
  //   note: null,
  //   inputNumber: 0,
  //   showNote: null,
  // );
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (widget.id != null) {
      TaskModel _editedTask = Provider.of<Tasks>(context, listen: false)
          .findById(widget.id as String);
      inputNumber = _editedTask.inputNumber;
      title = _editedTask.title;
      inputNumber = _editedTask.inputNumber;
      note = _editedTask.note;
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void handleShowNote() {
    setState(() {
      showNote = true;
    });
  }

  void handleInputChange(String value) {
    setState(() {
      inputNumber = int.tryParse(value) ?? 0;
    });
  }

  void handleUpClick() {
    setState(() {
      inputNumber++;
    });
  }

  void handleDownClick() {
    if (inputNumber > 0) {
      setState(() {
        inputNumber--;
      });
    }
  }

  void handleInputTitle(String value) {
    setState(() {
      title = value;
    });
  }

  void handleInputNote(String value) {
    setState(() {
      note = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints(maxWidth: 480),
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),

      // margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller:
                  TextEditingController(text: title != null ? '${title}' : ''),
              onChanged: handleInputTitle,
              decoration: InputDecoration(
                hintText: 'What are you working on?',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Color(0xFF555555).withOpacity(0.5)),
              ),
              style: const TextStyle(
                color: Color(0xFF555555),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    'Est Pomodoros',
                    style: TextStyle(
                      color: Color(0xFF555555),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 75,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0xFFEFEFEF),
                      ),
                      child: TextField(
                        onChanged: handleInputChange,
                        controller:
                            TextEditingController(text: '${inputNumber}'),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: TextStyle(
                          color: Color(0xFF555555),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter
                              .digitsOnly // chỉ cho phép nhập số
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                      child: GestureDetector(
                        onTap: handleUpClick,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xDFDFDF),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.2),
                                offset: Offset(0, 2),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_upward,
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: handleDownClick,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                          border: Border.all(
                            color: Color(0xDFDFDF),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.2),
                              offset: Offset(0, 2),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_downward,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          !showNote
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                  child: GestureDetector(
                    onTap: handleShowNote,
                    child: const Icon(Icons.notes),
                  ),
                )
              : Padding(
                  // padding: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),

                  child: TextField(
                    onChanged: handleInputNote,
                    decoration: const InputDecoration(
                      hintText: 'Add a note...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Color(0xFF555555)),
                    ),
                    style: const TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    maxLines: null,
                  ),
                ),
          Container(
            color: const Color(0xFFEFEFEF),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.checkAdd
                        ? Container()
                        : TextButton(
                            onPressed: () {
                              Provider.of<Tasks>(context, listen: false)
                                  .deleteTask(widget.id);
                              widget.handleCancelForm();
                            },
                            style: TextButton.styleFrom(
                              primary: const Color(0xFF888888),
                              textStyle: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                            child: const Text('Delete'),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: TextButton(
                            onPressed: () => widget.handleCancelForm(),
                            style: TextButton.styleFrom(
                              primary: const Color(0xFF888888),
                              textStyle: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                            child: const Text('Cancel'),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final _editedTask = TaskModel(
                              id: Uuid().v4(),
                              title: title!,
                              note: note,
                              inputNumber: inputNumber,
                              inputNumber1: inputNumber1,
                              check: check,
                            );
                            widget.checkAdd
                                ? Provider.of<Tasks>(context, listen: false)
                                    .addTask(_editedTask)
                                : Provider.of<Tasks>(context, listen: false)
                                    .updateTask(widget.id, _editedTask);
                            widget.handleCancelForm();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF222222),
                            onPrimary: Colors.white,
                            textStyle: const TextStyle(
                              fontSize: 14.0,
                            ),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          child: const Text('Add Task'),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
