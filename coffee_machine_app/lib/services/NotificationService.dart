import 'package:flutter/material.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  late BuildContext _context;

  void setContext(BuildContext context) {
    _context = context;
  }

  void showSuccess(String message) {
    _showSnackBar(message, Colors.green);
  }

  void showError(String message) {
    _showSnackBar(message, Colors.red);
  }

  void showInfo(String message) {
    _showSnackBar(message, Colors.blue);
  }

  void showProgress(String message) {
    _showSnackBar(message, Colors.orange);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
