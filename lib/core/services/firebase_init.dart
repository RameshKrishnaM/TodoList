import 'package:firebase_core/firebase_core.dart';
import 'package:todoapp/firebase_options.dart';

class FirebaseInit {
  static Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
