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
      appBar: AppBar(
        title: Text("Delete Task"),
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffB81736), // Red shade 1
                Color(0xff9B1A3E), // Dark red shade 2
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffB81736), // Red shade 1
              Color(0xff281537), // Dark red shade 2
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are You Sure, You want to delete the task "$taskTitle"?',
              style: TextStyle(
                fontSize: 20, // Slightly larger font size
                color: Colors.white, // White text for contrast
                fontWeight: FontWeight.bold, // Bold text for emphasis
                fontFamily: 'Montserrat', // Stylish font family
                letterSpacing: 1.2, // Slight letter spacing for style
              ),
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
