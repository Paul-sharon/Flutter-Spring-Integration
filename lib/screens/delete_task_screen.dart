import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DeleteTaskScreen extends StatelessWidget {
  final int taskId;
  final String taskTitle;
  final VoidCallback onTaskDeleted;

  DeleteTaskScreen({
    required this.taskId,
    required this.taskTitle,
    required this.onTaskDeleted,
  });

  void deleteTask(BuildContext context) {
    ApiService().deleteTask(taskId).then((_) {
      onTaskDeleted();
      Navigator.pop(context); // Close the confirmation screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Delete Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to delete the task "$taskTitle"?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context), // Cancel deletion
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () => deleteTask(context),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text("Delete"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
