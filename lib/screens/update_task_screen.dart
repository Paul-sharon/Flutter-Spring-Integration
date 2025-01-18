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
      appBar: AppBar(
        backgroundColor: Color(0xff1A5370),
        title: Text("Update Task"),
        foregroundColor: Colors.white, // White title text
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1E3C72), // Blue shade 1
              Color(0xff1A5370), // Intermediary shade (lighter blue)
              Color(0xff2A6F91), // Dark blue shade 2
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
              'Update the task "${widget.task.title}"', // Corrected here
              style: TextStyle(
                fontSize: 20, // Slightly larger font size
                color: Colors.white, // White text for contrast
                fontWeight: FontWeight.bold, // Bold text for emphasis
                fontFamily: 'Montserrat', // Stylish font family
                letterSpacing: 1.2, // Slight letter spacing for style
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
                labelStyle: TextStyle(color: Colors.white), // White label text
                hintStyle: TextStyle(color: Colors.white),  // White hint text (if you use a hint)
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // White underline when focused
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // White underline when not focused
                ),
              ),
              style: TextStyle(color: Colors.white), // White text for input
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: TextStyle(color: Colors.white), // White label text
                hintStyle: TextStyle(color: Colors.white),  // White hint text (if you use a hint)
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // White underline when focused
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // White underline when not focused
                ),
              ),
              style: TextStyle(color: Colors.white), // White text for input
            ),

            CheckboxListTile(
              value: isCompleted,
              onChanged: (bool? value) {
                setState(() {
                  isCompleted = value!;
                });
              },
              title: Text("Completed", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context), // Cancel update
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: updateTask,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text("Update Task"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
