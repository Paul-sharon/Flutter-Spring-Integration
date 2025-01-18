import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/task.dart';
import 'add_task_screen.dart';
import 'update_task_screen.dart';
import 'delete_task_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Task>> tasks;

  @override
  void initState() {
    super.initState();
    tasks = apiService.fetchTasks();
  }

  void refreshTasks() {
    setState(() {
      tasks = apiService.fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'To-Do List',
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffB81736),
                  Color(0xff281537),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xffB81736),
              Color(0xff281537),
            ]),
          ),
          child: Column(
            children: [
              SizedBox(height: 30), // Space between AppBar and body
              Expanded(
                child: FutureBuilder<List<Task>>(
                  future: tasks,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: TextStyle(color: Colors.white70),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'No tasks available.',
                          style: TextStyle(color: Colors.white70),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Task task = snapshot.data![index];
                          return Card(
                            elevation: 4,
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            child: ListTile(
                              title: Text(
                                task.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  decoration: task.completed
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              subtitle: Text(task.description),
                              trailing: Checkbox(
                                value: task.completed,
                                onChanged: (bool? value) {
                                  Task updatedTask = Task(
                                    id: task.id,
                                    title: task.title,
                                    description: task.description,
                                    completed: value!,
                                  );
                                  apiService.updateTask(task.id!, updatedTask).then((_) {
                                    refreshTasks();
                                  });
                                },
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateTaskScreen(
                                      task: task,
                                      onTaskUpdated: refreshTasks,
                                    ),
                                  ),
                                );
                              },
                              onLongPress: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DeleteTaskScreen(
                                      taskId: task.id!,
                                      taskTitle: task.title,
                                      onTaskDeleted: refreshTasks,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal, // Sets the button color to green teal
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(onTaskAdded: refreshTasks),
              ),
            );
          },
        ),
      ),
    );
  }
}
