import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/view/screens/task_list_screen.dart';

import 'core/services/firebase_init.dart';
import 'view/screens/login_screen.dart';
import 'view_model/auth_view_model.dart';
import 'view_model/share_view_model.dart';
import 'view_model/task_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInit.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => TaskViewModel()),
        ChangeNotifierProvider(create: (_) => ShareViewModel()),
      ],
      child: MaterialApp(
        title: 'Shared TODOs',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        home: LoginScreen(),
        routes: {
        '/login': (context) => const LoginScreen(),
        '/tasklist': (context) => const TaskListScreen(),
    },
      ),
    );
  }
}
