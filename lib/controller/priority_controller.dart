import 'package:flutter/material.dart';
import 'package:todo_provider/model/todo_model.dart';

class PriorityController extends ChangeNotifier{
  TaskPriority taskPriority = TaskPriority.low;

  void changePriority(TaskPriority pri){
    taskPriority = pri;
    notifyListeners();
    print('priority changes to $pri');
  }
}