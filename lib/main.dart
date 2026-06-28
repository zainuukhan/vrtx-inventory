import 'package:flutter/material.dart';
import 'app.dart';
import 'database/hive_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveDatabase.init();

  runApp(const App());
}
