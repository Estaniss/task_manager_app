import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/screens/my_home_page.dart';
import 'package:task_manager_app/blocs/task_bloc.dart';
import 'package:task_manager_app/repositories/task_repository.dart';

void main() {
  runApp(
    BlocProvider<TaskBloc>(
      create: (context) => TaskBloc(TaskRepository()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tarefas'),
    );
  }
}