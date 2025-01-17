// lib/services/task_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';

class TaskService {
  static const String _baseUrl = 'http://your-backend-url/api/tasks';

  static Future<List<Task>> getTasks() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> taskListJson = json.decode(response.body);
      return taskListJson.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  static Future<Task> addTask(Task task) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );

    if (response.statusCode == 201) {
      return Task.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add task');
    }
  }

  static Future<void> updateTask(Task task) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/${task.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update task');
    }
  }

  static Future<void> deleteTask(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }
}
