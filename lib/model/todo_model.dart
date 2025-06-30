enum TaskPriority { low, medium, high }

class TodoModel{
  String title;
  String description;
  String dueDate;
  TaskPriority priority;
  bool isCompleted = false;

  TodoModel({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
  });
}