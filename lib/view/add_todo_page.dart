import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controller/todo_controller.dart';
import '../model/todo_model.dart';

class AddTodoPage extends StatelessWidget {
  AddTodoPage({super.key});

  String selected = '';

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();

  Widget buildPriorityTile(String label, Color color) {
    final isSelected = selected == label;

    return Expanded(
      child: InkWell(
        // onTap: () => selectPriority(label),
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: 6),
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.15) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? color : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                label == 'High'
                    ? Icons.local_fire_department
                    : label == 'Medium'
                    ? Icons.flash_on
                    : Icons.nightlight_round,
                color: color,
              ),
              SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Task Title',
              hintText: 'What needs to be done?',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _descriptionController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Description',
              hintText: 'Add more details about your task...',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _dueDateController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Due Date',
              hintText: 'dd-mm-yyyy',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.calendar_today),
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                String formattedDate = DateFormat('dd MMM').format(pickedDate);
                _dueDateController.text = formattedDate;
              }
            },
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
              child: Row(
                children: [
                  buildPriorityTile('High', Colors.red),
                  buildPriorityTile('Medium', Colors.orange),
                  buildPriorityTile('Low', Colors.blue),
                ],
              ),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              context.read<TodoController>().addUser(
                TodoModel(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  dueDate: _dueDateController.text,
                  priority: TaskPriority.medium,
                ),
              );
            },
            child: Text('Add Todo'),
          ),
        ],
      ),
    );
  }
}
