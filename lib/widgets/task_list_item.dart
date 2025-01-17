// lib/widgets/task_list_item.dart

import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final Function(Task) onEdit;

  TaskListItem({required this.task, required this.onEdit});

  void _toggleCompletion(BuildContext context) async {
    Task updatedTask = Task(
      id: task.id,
      title: task.title,
      description: task.description,
      completed: !task.completed,
    );
    await TaskService.updateTask(updatedTask);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task updated')),
    );
  }

  void _deleteTask(BuildContext context) async {
    await TaskService.deleteTask(task.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.completed ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Text(task.description),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              task.completed ? Icons.check_box : Icons.check_box_outline_blank,
              color: task.completed ? Colors.green : null,
            ),
            onPressed: () => _toggleCompletion(context),
          ),
          IconButton(
            icon: Icon(Icons.edit, color: Colors.blue),
            onPressed: () => onEdit(task),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () => _deleteTask(context),
          ),
        ],
      ),
    );
  }
}
