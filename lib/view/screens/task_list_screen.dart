import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../view_model/auth_view_model.dart';
import '../../view_model/share_view_model.dart';
import '../../view_model/task_view_model.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final user = context.read<AuthViewModel>().currentUser;
      if (user == null) {
        debugPrint('User is null! Cannot listen to tasks');
      } else {
        debugPrint('Listening to tasks for userId: ${user.uid}');
        context.read<TaskViewModel>().listenToTasks(user.uid);
      }
    });
  }

  void _addTask() {
    final title = taskController.text.trim();
    final userId = context.read<AuthViewModel>().currentUser!.uid;
    if (title.isNotEmpty) {
      context.read<TaskViewModel>().addTask(title, userId);
      taskController.clear();
    }
  }

  void _showShareDialog(String taskId) {
    final TextEditingController emailController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share Task'),
        content: TextField(
          controller: emailController,
          decoration: const InputDecoration(hintText: 'Enter user email'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final email = emailController.text.trim();
              context.read<ShareViewModel>().shareTask(taskId, email);
              Navigator.pop(context);
            },
            child: const Text('Share'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskVM = context.watch<TaskViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('📝 Shared Tasks'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await context.read<AuthViewModel>().signOut();

              // Navigate back to login page (replace so user can’t go back)
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      hintText: 'Enter a new task',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: taskVM.tasks.isEmpty
                ? const Center(child: Text("No tasks available"))
                : ListView.builder(
                    itemCount: taskVM.tasks.length,
                    itemBuilder: (_, index) {
                      final task = taskVM.tasks[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(task.title),
                          subtitle: Text(
                            'By: ${task.ownerId.substring(0, 5)}...',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.send,
                                  color: Colors.blueAccent,
                                ),
                                onPressed: () => Share.share(task.title),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.share,
                                  color: Colors.deepPurple,
                                ),
                                onPressed: () => _showShareDialog(task.id),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => taskVM.deleteTask(task.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
