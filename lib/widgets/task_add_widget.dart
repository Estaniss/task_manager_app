import 'package:flutter/material.dart';
import 'package:task_manager_app/models/task.dart';

class AddTaskFormWidget extends StatelessWidget {
  final Function(Task) onTaskSubmitted;

  AddTaskFormWidget({super.key, required this.onTaskSubmitted});

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _deadlineController = TextEditingController();
  final _priorityController = TextEditingController();

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
                  final task = Task(
                    id: 0, // Será gerado automaticamente pelo banco de dados
                    title: _titleController.text,
                    description: _descriptionController.text,
                    deadline: DateTime.parse(_deadlineController.text),
                    isCompleted: false,
                    priority: int.parse(_priorityController.text),
                  );

                  onTaskSubmitted(task);
                  _titleController.clear();
                  _descriptionController.clear();
                  _deadlineController.clear();
                  _priorityController.clear();
                }
              },
              child: const Text('Adicionar Tarefa'),
            ),
          ],
        ),
      ),
    );
  }
}