import 'package:flutter/material.dart';

import 'screens/expense_tracker_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatefulWidget {
  const ExpenseTrackerApp({super.key});

  @override
  State<ExpenseTrackerApp> createState() => _ExpenseTrackerAppState();
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  bool _forestMode = false;

  void _toggleTheme() {
    setState(() {
      _forestMode = !_forestMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: _forestMode ? AppTheme.forestTheme : AppTheme.darkTheme,
      home: ExpenseTrackerScreen(
        forestMode: _forestMode,
        onThemeChanged: _toggleTheme,
      ),
    );
  }
}