import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/api_service.dart';

class UpdateTaskScreen extends StatefulWidget {
  final Task task;
  final VoidCallback onTaskUpdated;

  UpdateTaskScreen({required this.task, required this.onTaskUpdated});

  @override
  _UpdateTaskScreenState createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(text: widget.task.description);
    isCompleted = widget.task.completed;
  }

  void updateTask() {
    ApiService().updateTask(
      widget.task.id!,
      Task(
        id: widget.task.id,
        title: titleController.text,
        description: descriptionController.text,
        completed: isCompleted,
      ),
    ).then((_) {
      widget.onTaskUpdated();
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Task")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "Description"),
            ),
            CheckboxListTile(
              value: isCompleted,
              onChanged: (bool? value) {
                setState(() {
                  isCompleted = value!;
                });
              },
              title: Text("Completed"),
            ),
            ElevatedButton(
              onPressed: updateTask,
              child: Text("Update Task"),
            ),
          ],
        ),
      ),
    );
  }
}
