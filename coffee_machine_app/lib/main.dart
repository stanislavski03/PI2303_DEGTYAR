import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'app_state.dart';

void main() {
  final appState = AppState();
  appState.initialize();

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
