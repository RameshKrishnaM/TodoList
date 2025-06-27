import 'package:flutter/material.dart';

import '../core/models/task_model.dart';
import '../core/services/firestore_service.dart';

class TaskViewModel with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  void listenToTasks(String userId) {
    _firestoreService.getTasks(userId).listen((tasks) {
      _tasks = tasks;
      notifyListeners();
    });
  }

  Future<void> addTask(String title, String userId) async {
    final newTask = TaskModel(
      id: '',
      title: title,
      ownerId: userId,
      sharedWith: [userId],
      createdAt: DateTime.now(),
    );
    await _firestoreService.addTask(newTask);
  }

  Future<void> deleteTask(String id) => _firestoreService.deleteTask(id);
}
