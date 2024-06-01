import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/models/task.dart';
import 'package:task_manager_app/repositories/task_repository.dart';

// Definindo os estados
abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  TaskLoaded(this.tasks);
}

class TaskError extends TaskState {
  final String message;

  TaskError(this.message);
}

// Definindo os eventos
abstract class TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final Task task;

  AddTaskEvent(this.task);
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;

  UpdateTaskEvent(this.task);
}

class DeleteTaskEvent extends TaskEvent {
  final int id;

  DeleteTaskEvent(this.id);
}

// Implementando o TaskBloc
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _taskRepository;

  TaskBloc(this._taskRepository) : super(TaskInitial()) {
    on<AddTaskEvent>((event, emit) async {
      emit(TaskLoading());
      try {
        await _taskRepository.addTask(event.task);
        final updatedTasks = await _taskRepository.getAllTasks();
        emit(TaskLoaded(updatedTasks));
      } catch (e) {
        emit(TaskError('Erro ao adicionar tarefa'));
      }
    });

    on<UpdateTaskEvent>((event, emit) async {
      emit(TaskLoading());
      try {
        await _taskRepository.updateTask(event.task);
        final updatedTasks = await _taskRepository.getAllTasks();
        emit(TaskLoaded(updatedTasks));
      } catch (e) {
        emit(TaskError('Erro ao atualizar tarefa'));
      }
    });

    on<DeleteTaskEvent>((event, emit) async {
      emit(TaskLoading());
      try {
        await _taskRepository.deleteTask(event.id);
        final updatedTasks = await _taskRepository.getAllTasks();
        emit(TaskLoaded(updatedTasks));
      } catch (e) {
        emit(TaskError('Erro ao deletar tarefa'));
      }
    });
  }
}