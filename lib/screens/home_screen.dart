// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_list_item.dart';
import '../services/task_service.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  void _fetchTasks() async {
    try {
      List<Task> fetchedTasks = await TaskService.getTasks();
      setState(() {
        tasks = fetchedTasks;
      });
    } catch (e) {
      // Handle the error by showing a message or logging
      print('Error fetching tasks: $e');
    }
  }

  void _navigateToAddTaskScreen() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddTaskScreen()),
    );
    _fetchTasks(); // Refresh the task list after adding a new task
  }

  void _navigateToEditTaskScreen(Task task) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => EditTaskScreen(task: task)),
    );
    _fetchTasks(); // Refresh the task list after editing a task
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo App')),
      body: tasks.isEmpty
          ? Center(child: Text('No tasks available'))
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskListItem(
            task: tasks[index],
            onEdit: _navigateToEditTaskScreen,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _navigateToAddTaskScreen,
      ),
    );
  }
}
