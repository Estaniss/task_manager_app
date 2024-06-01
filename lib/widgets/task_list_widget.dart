import 'package:flutter/material.dart';
import 'package:task_manager_app/models/task.dart';
import 'package:task_manager_app/widgets/task_tile_widget.dart';

class TaskListWidget extends StatelessWidget {
  final List<Task> tasks;

  const TaskListWidget({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskTileWidget(
          task: task,
          onChanged: (bool? value) {
            // Atualizar o estado da tarefa
            // ...
          },
          onEdit: () {
            // Navegar para a tela de edição de tarefas
            // ...
          },
        );
      },
    );
  }
}