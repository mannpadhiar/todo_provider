import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controller/priority_controller.dart';
import '../controller/todo_controller.dart';
import '../model/todo_model.dart';

class AddTodoPage extends StatelessWidget {
  AddTodoPage({super.key});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  
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
              child: Consumer<PriorityController>(
                builder: (context, provider, child) => Row(
                  children: [
                    // High Priority Tile
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          provider.changePriority(TaskPriority.high);
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: provider.taskPriority == TaskPriority.high ? Colors.red.withOpacity(0.15) : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: provider.taskPriority == TaskPriority.high ? Colors.red : Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.local_fire_department, color: Colors.red),
                              SizedBox(height: 8),
                              Text('High', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Medium Priority Tile
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          provider.changePriority(TaskPriority.medium);
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: provider.taskPriority == TaskPriority.medium ? Colors.orange.withOpacity(0.15) : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: provider.taskPriority == TaskPriority.medium ? Colors.orange : Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.flash_on, color: Colors.orange),
                              SizedBox(height: 8),
                              Text('Medium', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Low Priority Tile
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          provider.changePriority(TaskPriority.low);
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: provider.taskPriority == TaskPriority.low ? Colors.blue.withOpacity(0.15) : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: provider.taskPriority == TaskPriority.low ? Colors.blue : Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.nightlight_round, color: Colors.blue),
                              SizedBox(height: 8),
                              Text('Low', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
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
