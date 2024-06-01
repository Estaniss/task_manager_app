import 'package:sqflite/sqflite.dart';
import 'package:task_manager_app/models/task.dart';

class TaskRepository {
  Future<Database> _getDatabase() async {
    final databasePath = await getDatabasesPath();
    return await openDatabase(
      '$databasePath/task_manager.db',
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE tasks(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT NOT NULL,
              description TEXT,
              deadline TEXT,
              isCompleted INTEGER NOT NULL,
              priority INTEGER NOT NULL)''',
        );
      },
      version: 1,
    );
  }

  Future<List<Task>> getAllTasks() async {
    final db = await _getDatabase();
    final maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  Future<void> addTask(Task task) async {
    final db = await _getDatabase();
    await db.insert('tasks', task.toMap());
  }

  Future<void> updateTask(Task task) async {
    final db = await _getDatabase();
    await db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<void> deleteTask(int taskId) async {
    final db = await _getDatabase();
    await db.delete('tasks', where: 'id = ?', whereArgs: [taskId]);
  }
}