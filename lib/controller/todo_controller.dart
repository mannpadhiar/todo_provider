import 'package:flutter/material.dart';
import 'package:todo_provider/model/todo_model.dart';

class TodoController extends ChangeNotifier{
  List<TodoModel> todos = [
    TodoModel(
      title: 'Schedule dentist appointment',
      description: 'Call and schedule the appointment at 10 AM.',
      dueDate: '01-07-2025',
      priority: TaskPriority.high,
    ),
  ];

  void addUser(TodoModel todo){
    todos.add(todo);
    notifyListeners();
  }

  void deleteUser(TodoModel todo){
    todos.remove(todo);
    notifyListeners();
    print('user deleted');
  }

  void updateUser(){

  }
}