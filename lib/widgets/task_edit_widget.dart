import 'package:flutter/material.dart';
import 'package:task_manager_app/models/task.dart';
import 'package:intl/intl.dart';

class EditTaskFormWidget extends StatelessWidget {
  final Task task;
  final Function(Task) onTaskUpdated;

  EditTaskFormWidget({super.key, required this.task, required this.onTaskUpdated});

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _deadlineController = TextEditingController();
  final _priorityController = TextEditingController();

  void initState() {
    _titleController.text = task.title;
    _descriptionController.text = task.description;
    _deadlineController.text = DateFormat('dd/MM/yyyy').format(task.deadline);
    _priorityController.text = task.priority.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Título é obrigatório';
                }
                return null;
              },
            ),
           const SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
              maxLines: 5,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _deadlineController,
              decoration: const InputDecoration(labelText: 'Data Limite'),
              keyboardType: TextInputType.datetime,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Data limite é obrigatória';
                }
                try {
                  DateFormat('dd/MM/yyyy').parse(value);
                } catch (_) {
                  return 'Formato de data inválido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _priorityController,
              decoration: const InputDecoration(labelText: 'Prioridade'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final updatedTask = Task(
                    id: task.id,
                    title: _titleController.text,
                    description: _descriptionController.text,
                    deadline: DateFormat('dd/MM/yyyy').parse(_deadlineController.text),
                    isCompleted: task.isCompleted,
                    priority: int.parse(_priorityController.text),
                  );

                  onTaskUpdated(updatedTask);
                  Navigator.pop(context);
                }
              },
              child: const Text('Salvar Tarefa'),
            ),
          ],
        ),
      ),
    );
  }
}