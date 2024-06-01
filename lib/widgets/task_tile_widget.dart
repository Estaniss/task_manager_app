import 'package:flutter/material.dart';
import 'package:task_manager_app/models/task.dart';

class TaskTileWidget extends StatelessWidget {
  final Task task;
  final Function(bool?) onChanged;
  final Function() onEdit;

  const TaskTileWidget({super.key, 
    required this.task,
    required this.onChanged,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: onChanged,
      ),
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: onEdit,
      ),
    );
  }
}