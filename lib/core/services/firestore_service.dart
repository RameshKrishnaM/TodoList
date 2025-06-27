import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task_model.dart';

class FirestoreService {
  final _tasksRef = FirebaseFirestore.instance.collection('tasks');

  Stream<List<TaskModel>> getTasks(String userId) {
    return _tasksRef
        .where('sharedWith', arrayContains: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TaskModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<void> addTask(TaskModel task) async {
    final docRef = await _tasksRef.add(task.toMap());

    // After Firestore generates the document, update it with its own ID
    await docRef.update({'id': docRef.id});
  }

  Future<void> updateTask(TaskModel task) async {
    await _tasksRef.doc(task.id).update(task.toMap());
  }

  Future<void> deleteTask(String id) async {
    await _tasksRef.doc(id).delete();
  }
}
