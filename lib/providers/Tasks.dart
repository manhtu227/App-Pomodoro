// import 'dart:convert'; // thuw vien chuyen doi
import 'package:flutter/material.dart';
import '../models/TaskModel.dart';

class Tasks with ChangeNotifier {
  final List<TaskModel> _items = [
    TaskModel(
        id: "1",
        title: "toilet",
        note: "khong co j",
        inputNumber: 1,
        inputNumber1: 0,
        check: false),
    TaskModel(
        id: "2",
        title: "toilet",
        note: "khong co j",
        inputNumber: 2,
        inputNumber1: 0,
        check: false)
  ];
  String _selectedTaskId = 'khong';
  List<TaskModel> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  String get selectedTaskId {
    return _selectedTaskId;
  }

  void addTask(TaskModel Task) {
    final newTask = TaskModel(
        id: "2",
        title: Task.title,
        note: Task.note,
        inputNumber: Task.inputNumber,
        inputNumber1: Task.inputNumber1,
        check: Task.check);
    _items.add(newTask);
    notifyListeners();
  }

  void updateCheck(String id) {
    final taskIndex = _items.indexWhere((task) => task.id == id);
    if (taskIndex >= 0) {
      TaskModel taskToUpdate = _items[taskIndex];
      taskToUpdate.check = !taskToUpdate.check;
      _items[taskIndex] = taskToUpdate;
      notifyListeners();
    } else {
      print(_selectedTaskId);
      print(taskIndex);
      print(taskIndex);
    }
  }

  void updateInputNumber1() {
    final taskIndex = _items.indexWhere((task) => task.id == _selectedTaskId);
    if (taskIndex >= 0) {
      print("taskIndex");

      TaskModel taskToUpdate = _items[taskIndex];
      taskToUpdate.inputNumber1++;
      if (taskToUpdate.inputNumber1 == taskToUpdate.inputNumber) {
        taskToUpdate.check = true;
      } else if (taskToUpdate.inputNumber1 > taskToUpdate.inputNumber) {
        final nextTaskIndex = _items.indexWhere((task) => !task.check);
        if (nextTaskIndex >= 0) {
          _selectedTaskId = _items[nextTaskIndex].id;
        }
      }
      _items[taskIndex] = taskToUpdate;
      notifyListeners();
    } else {
      print(_selectedTaskId);
      print(taskIndex);
      print(taskIndex);
    }
  }

  void updateTask(String? id, TaskModel newTask) {
    final taskIndex = _items.indexWhere((prod) => prod.id == id);
    if (taskIndex >= 0) {
      _items[taskIndex] = newTask;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void clearFinishTask() {
    int nextTaskIndex;
    do {
      nextTaskIndex = _items.indexWhere((task) => task.check);
      if (nextTaskIndex >= 0) {
        deleteTask(_items[nextTaskIndex].id);
      }
    } while (nextTaskIndex >= 0);
    notifyListeners();
  }

  void clearAllTask() {
    _selectedTaskId = 'khong';
    _items.clear();
    notifyListeners();
  }

  void deleteTask(String? id) {
    _items.removeWhere((prod) => prod.id == id);
    if (_selectedTaskId == id) {
      final nextTaskIndex = _items.indexWhere((task) => !task.check);
      if (nextTaskIndex >= 0) {
        _selectedTaskId = _items[nextTaskIndex].id;
      } else
        _selectedTaskId = 'khong';
    }
    print("_selectedTaskIdddddddddddd");
    print(_selectedTaskId);
    notifyListeners();
  }

  void selectTask(String id) {
    _selectedTaskId = id;
    notifyListeners();
  }

  TaskModel findById(String id) {
    return _items.firstWhere((task) => task.id == id);
  }

  String getTitle() {
    // print('_items.firstWhere((task) => task.id == _selectedTaskId)');
    final taskIndex = _items.indexWhere((task) => task.id == _selectedTaskId);
    // notifyListeners();
    return _items[taskIndex].title;
  }
}
