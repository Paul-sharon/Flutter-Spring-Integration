import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  final VoidCallback onTaskAdded;

  AddTaskScreen({required this.onTaskAdded});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isCompleted = false;

  void saveTask() {
    ApiService().addTask(Task(
      title: titleController.text,
      description: descriptionController.text,
      completed: isCompleted,
    )).then((_) {
      widget.onTaskAdded();
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            CheckboxListTile(
              value: isCompleted,
              onChanged: (bool? value) {
                setState(() {
                  isCompleted = value!;
                });
              },
              title: Text('Completed'),
            ),
            ElevatedButton(
              onPressed: saveTask,
              child: Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
