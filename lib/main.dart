import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/controller/todo_controller.dart';
import 'package:todo_provider/view/add_todo_page.dart';
import 'package:todo_provider/view/home_page.dart';

import 'controller/priority_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoController(),),
        ChangeNotifierProvider(create: (context) => PriorityController(),),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: HomePage(),
      ),
    );
  }
}
