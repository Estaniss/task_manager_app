import 'package:task_manager_app/models/task.dart';

class TaskEvent {
  final Task? task;
  final int? id;

  TaskEvent({this.task, this.id});
}

enum TaskEventType {
  addTask,
  updateTask,
  deleteTask,
}

class AddTaskEvent extends TaskEvent {
  @override
  final Task task;
  AddTaskEvent({required this.task}); // Constructor with required 'task' argument
}

class UpdateTaskEvent extends TaskEvent {
  UpdateTaskEvent(Task task) : super(task: task);
}

class DeleteTaskEvent extends TaskEvent {
  DeleteTaskEvent(int id) : super(id: id);
}