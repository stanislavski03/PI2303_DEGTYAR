import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const CoffeeMachineApp());
}

class CoffeeMachineApp extends StatelessWidget {
  const CoffeeMachineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Machine',
      theme: ThemeData(primarySwatch: Colors.brown, useMaterial3: true),
      home: const MainScreen(),
    );
  }
}
