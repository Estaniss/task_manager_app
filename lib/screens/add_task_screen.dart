import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app/blocs/task_bloc.dart';
import 'package:task_manager_app/models/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _deadlineController = TextEditingController();
  final _priorityController = TextEditingController();
  final dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _deadlineController.dispose();
    _priorityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Tarefa'),
      ),
      body: Form(
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
                    return 'Data Limite é obrigatória';
                  }
                  final validDate = RegExp(r'^\d{2}/\d{2}/\d{4}$');
                  if (!validDate.hasMatch(value)) {
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
                  print("Botão 'Adicionar Tarefa' pressionado");
                  if (_formKey.currentState!.validate()) {
                    print("Formulário válido. Salvando tarefa...");
                    final task = Task(
                      id: 0, // Será gerado automaticamente pelo banco de dados
                      title: _titleController.text,
                      description: _descriptionController.text,
                      deadline: dateFormat.parse(_deadlineController.text),
                      isCompleted: false,
                      priority: int.parse(_priorityController.text),
                    );

                    print("Tarefa a ser salva: $task");

                    BlocProvider.of<TaskBloc>(context).add(AddTaskEvent(task));
                    Navigator.pop(context);
                  } else {
                    print("Formulário inválido. Não é possível salvar a tarefa.");
                  }
                },
                child: const Text('Adicionar Tarefa'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}