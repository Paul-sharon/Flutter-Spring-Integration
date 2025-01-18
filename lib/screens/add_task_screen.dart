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
    if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
      ApiService()
          .addTask(Task(
        title: titleController.text,
        description: descriptionController.text,
        completed: isCompleted,
      ))
          .then((_) {
        widget.onTaskAdded();
        Navigator.pop(context);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff008080), // Teal green
                Color(0xff00998F), // Aqua green
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff008080), // Teal green
              Color(0xff00FFCC), // Aqua green
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title input field
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16),

              // Description input field
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16),

              // Completed Checkbox
              CheckboxListTile(
                value: isCompleted,
                onChanged: (bool? value) {
                  setState(() {
                    isCompleted = value!;
                  });
                },
                title: Text(
                  'Completed',
                  style: TextStyle(color: Colors.white70),
                ),
                checkColor: Colors.black,
                activeColor: Colors.teal,
              ),
              SizedBox(height: 16),

              // Save button
              Center(
                child: ElevatedButton(
                  onPressed: saveTask,
                  child: Text('Save Task'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Button color
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
