class Task {
  final int? id;
  final String title;
  final String description;
  final bool completed;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.completed,
  });

  factory Task.fromJson(Map<String, dynamic> json) { //factory constructor from server to task object
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() { //task object to server
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
    };
  }
}
