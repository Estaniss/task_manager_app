import 'package:intl/intl.dart';

class Task {
  final int id;
  final String title;
  final String description;
  final DateTime deadline;
  final bool isCompleted;
  final int priority;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.deadline,
    required this.isCompleted,
    required this.priority,
  });

  Map<String, dynamic> toMap() {
    final dateFormat = DateFormat('dd/MM/yyyy');
    return {
      'id': id,
      'title': title,
      'description': description,
      'deadline': dateFormat.format(deadline), // Formata como dd/MM/yyyy
      'isCompleted': isCompleted ? 1 : 0,
      'priority': priority,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    return Task(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      deadline: dateFormat.parse(map['deadline'] as String), // Analisa dd/MM/yyyy
      isCompleted: (map['isCompleted'] as int) == 1,
      priority: map['priority'] as int,
    );
  }
}