import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tailor_app_final_final/firebase_options.dart';
import 'package:tailor_app_final_final/screens/screens.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const DataCheck());
}
