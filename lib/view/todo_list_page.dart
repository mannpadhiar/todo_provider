import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../controller/todo_controller.dart';
import '../model/todo_model.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  void showTaskDetails(BuildContext context, TodoModel todo, int index, TodoController provider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),

              Center(
                child: Text(
                  'Task Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              SizedBox(height: 25),

              detailTile(
                icon: Icons.title,
                title: "Title",
                value: todo.title,
              ),
              detailTile(
                icon: Icons.description,
                title: "Description",
                value: todo.description?.trim().isNotEmpty == true ? todo.description! : "No description",
              ),
              detailTile(
                icon: Icons.calendar_today,
                title: "Due Date",
                value: todo.dueDate,
              ),
              detailTile(
                icon: Icons.priority_high,
                title: "Priority",
                value: todo.priority.name.toUpperCase(),
                valueColor: choosePriorityChipColor(todo.priority),
              ),

              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.edit, color: Colors.white),
                      label: Text("Edit", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),
                      onPressed: () {
                        Navigator.pop(context);
                        showEditTaskDialog(context,provider.todos[index],index,provider);
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.close),
                      label: Text("Close"),
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget detailTile({
    required IconData icon,
    required String title,
    required String value,
    Color? valueColor,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.indigo.shade100 ,width: 3),
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.indigo, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: valueColor ?? Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Color choosePriorityChipColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return Colors.redAccent;
      case TaskPriority.medium:
        return Colors.orangeAccent;
      case TaskPriority.low:
        return Colors.blueAccent;
    }
  }

  Widget buildEmptyTodoMessage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.playlist_add_check_circle_outlined,
              size: 80,
              color: Colors.indigo.withOpacity(0.6),
            ),
            SizedBox(height: 16),
            Text(
              'No Tasks Yet!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Tap the + button to add your first todo.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer<TodoController>(
            builder: (context, provider, child) => provider.todos.isEmpty?buildEmptyTodoMessage() : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: provider.todos.length,
              itemBuilder: (context, index) {
                return Slidable(
                  key: ValueKey(provider.todos[index].title),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.12,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          child: IconButton(
                            onPressed: () {
                              provider.deleteUser(provider.todos[index]);
                            },
                            icon: Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4),
                      ],
                    ),
                    child: ListTile(
                      onTap:() =>  showTaskDetails(context,provider.todos[index],index,provider),
                      leading: IconButton(
                        onPressed: () {
                          provider.changeIsCompleted(index);
                        },
                        icon: Icon(
                          provider.todos[index].isCompleted
                              ? Icons.check_circle_outline_rounded
                              : Icons.circle_outlined,
                          color: Colors.indigo,
                          size: 30,
                        ),
                      ),
                      title: Text(
                        provider.todos[index].title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(provider.todos[index].dueDate),
                      trailing: Chip(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        backgroundColor: choosePriorityChipColor(
                          provider.todos[index].priority,
                        ),
                        label: Text(
                          provider.todos[index].priority.name
                              .toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        labelPadding:
                            EdgeInsets.zero, // Removes internal spacing bloat
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void showEditTaskDialog(BuildContext context, TodoModel todo, int index, TodoController provider) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController titleController = TextEditingController(text: todo.title);
    final TextEditingController descController = TextEditingController(text: todo.description ?? '');
    DateTime selectedDate = DateTime.tryParse(todo.dueDate) ?? DateTime.now();
    TaskPriority selectedPriority = todo.priority;

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("Edit Task"),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Title required' : null,
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: descController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 12),
                  InkWell(
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        selectedDate = picked;
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Due Date: ${selectedDate.toIso8601String().substring(0, 10)}",
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  DropdownButtonFormField<TaskPriority>(
                    value: selectedPriority,
                    decoration: InputDecoration(
                      labelText: 'Priority',
                      border: OutlineInputBorder(),
                    ),
                    items: TaskPriority.values.map((priority) {
                      return DropdownMenuItem(
                        value: priority,
                        child: Text(priority.name.toUpperCase()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) selectedPriority = value;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  provider.updateUser(
                    todo,
                    TodoModel(
                      title: titleController.text.trim(),
                      description: descController.text.trim(),
                      dueDate: selectedDate.toIso8601String().substring(0, 10), // Save as string
                      priority: selectedPriority,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }


}
