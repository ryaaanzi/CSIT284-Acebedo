
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'expense_tracker_screen.dart';
import 'settings_screen.dart';
import 'statistics_screen.dart';

class AppNavigationScreen extends StatefulWidget {
  const AppNavigationScreen({
    required this.forestMode,
    required this.onThemeChanged,
    super.key,
  });

  final bool forestMode;
  final VoidCallback onThemeChanged;

  @override
  State<AppNavigationScreen> createState() =>
      _AppNavigationScreenState();
}

class _AppNavigationScreenState extends State<AppNavigationScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      ExpenseTrackerScreen(
        forestMode: widget.forestMode,
        onThemeChanged: widget.onThemeChanged,
      ),
      const StatisticsScreen(),
      SettingsScreen(
        forestMode: widget.forestMode,
        onThemeChanged: widget.onThemeChanged,
      ),
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: AppTheme.surface,
        indicatorColor: AppTheme.primary.withValues(alpha: 0.16),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart_rounded),
            label: 'Statistics',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
