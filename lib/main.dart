import 'package:flutter/material.dart';
import 'package:shared_preferences_practice/screens/practice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Shared Preferences',
      home: Practice(),
    );
  }
}
