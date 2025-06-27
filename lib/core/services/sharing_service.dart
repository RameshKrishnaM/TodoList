import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SharingService {
  final CollectionReference tasksRef = FirebaseFirestore.instance.collection(
    'tasks',
  );
  final CollectionReference usersRef = FirebaseFirestore.instance.collection(
    'users',
  );

  Future<void> shareTaskWithEmail(String taskId, String email) async {
    try {
      final userQuery = await usersRef.where('email', isEqualTo: email).get();
      if (userQuery.docs.isNotEmpty) {
        final userId = userQuery.docs.first.id;
        final taskDoc = await tasksRef.doc(taskId).get();
        final currentShared = List<String>.from(taskDoc['sharedWith'] ?? []);

        if (!currentShared.contains(userId)) {
          currentShared.add(userId);
          await tasksRef.doc(taskId).update({'sharedWith': currentShared});
          Fluttertoast.showToast(msg: 'Task shared with $email');
        } else {
          Fluttertoast.showToast(msg: 'Task already shared with $email');
        }
      } else {
        Fluttertoast.showToast(msg: 'User with email $email not found');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error sharing task: $e');
    }
  }
}
