import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyForm extends StatefulWidget {
  final Function handleCancelForm;

  MyForm(this.handleCancelForm);
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  bool showNote = false;
  int inputNumber = 0;
  String? title;
  String? note;

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
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                onChanged: handleInputTitle,
                decoration: InputDecoration(
                  hintText: 'What are you working on?',
                  border: InputBorder.none,
                  hintStyle:
                      TextStyle(color: Color(0xFF555555).withOpacity(0.5)),
                ),
                style: const TextStyle(
                  color: Color(0xFF555555),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
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
                ? GestureDetector(
                    onTap: handleShowNote,
                    child: const Icon(Icons.notes),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 8),
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
            Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: ElevatedButton(
                        onPressed: () => widget.handleCancelForm(),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF222222),
                          onPrimary: Colors.white,
                          textStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('Title: $title');
                        print('Est Pomodoros: $inputNumber');
                        print('Note: $note');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF222222),
                        onPrimary: Colors.white,
                        textStyle: TextStyle(
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
                )),
          ],
        ),
      ),
    );
  }
}
