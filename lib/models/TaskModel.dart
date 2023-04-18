class TaskModel {
  final String id;
  final String title;
  final String? note;
  final int inputNumber;
  int inputNumber1;
  bool check = false;

  TaskModel({
    required this.id,
    required this.title,
    required this.note,
    required this.inputNumber,
    required this.inputNumber1,
    required this.check,
  });
}
