// lib/screens/edit_task_screen.dart

import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  EditTaskScreen({required this.task});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late bool _completed;

  @override
  void initState() {
    super.initState();
    _title = widget.task.title;
    _description = widget.task.description;
    _completed = widget.task.completed;
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Task updatedTask = Task(
        id: widget.task.id,
        title: _title,
        description: _description,
        completed: _completed,
      );

      await TaskService.updateTask(updatedTask);
      Navigator.of(context).pop(); // Return to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Task')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  _description = value!;
                },
              ),
              Row(
                children: [
                  Checkbox(
                    value: _completed,
                    onChanged: (value) {
                      setState(() {
                        _completed = value!;
                      });
                    },
                  ),
                  Text('Completed'),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Update Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
