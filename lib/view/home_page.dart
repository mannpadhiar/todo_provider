import 'package:flutter/material.dart';
import 'package:todo_provider/view/add_todo_page.dart';
import 'package:todo_provider/view/todo_list_page.dart';


class HomePage extends StatefulWidget{
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  late TabController _tabController ;

  @override
  void initState() {
    super.initState();
    _tabController =  TabController(length: 2, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Tasks',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),backgroundColor: Colors.indigoAccent,),
      body: TabBarView(
        controller: _tabController,
        children: [
          TodoListPage(),
          AddTodoPage(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.green[100],
            ),
            child: TabBar(
              controller: _tabController,
              dividerColor: Colors.transparent,
              tabs: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.home),
                      const SizedBox(width: 2),
                      const Text('Home'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add),
                      const SizedBox(width: 2),
                      const Text('Add'),
                    ],
                  ),
                ),
              ],
              indicator: BoxDecoration(
                color: Color(0xFF0C6938),
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
