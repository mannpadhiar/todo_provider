import 'package:flutter/material.dart';
import 'package:todo_provider/model/todo_model.dart';

class TodoController extends ChangeNotifier{
  List<TodoModel> todos = [

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

  void updateUser(TodoModel oldTodo,TodoModel newTodo){
    int index = todos.indexOf(oldTodo);
    todos[index] = newTodo;
    notifyListeners();
  }

  void changeIsCompleted(int index){
    todos[index].isCompleted = !todos[index].isCompleted;
    notifyListeners();
  }
}