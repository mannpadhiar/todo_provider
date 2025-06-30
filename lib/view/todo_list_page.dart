import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../controller/todo_controller.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer<TodoController>(
            builder: (context, provider, child) => ListView.builder(
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
                          child: IconButton(onPressed: () {
                            provider.deleteUser(provider.todos[index]);
                          }, icon: Icon(Icons.delete,color: Colors.white,)),
                        ),
                      )
                    ],
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                    ),
                    child: ListTile(
                      title: Text(provider.todos[index].title, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(provider.todos[index].dueDate),
                      // trailing: _buildPriorityChip(todo.priority),
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
}
