
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    required this.forestMode,
    required this.onThemeChanged,
    super.key,
  });

  final bool forestMode;
  final VoidCallback onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'APPEARANCE',
            style: TextStyle(
              color: AppTheme.mutedGreen,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
            child: SwitchListTile(
              value: forestMode,
              onChanged: (_) => onThemeChanged(),
              activeThumbColor: AppTheme.primary,
              secondary: Icon(
                forestMode
                    ? Icons.forest_rounded
                    : Icons.nightlight_round,
                color: AppTheme.primary,
              ),
              title: const Text(
                'Forest Mode',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                forestMode
                    ? 'Forest theme is currently enabled.'
                    : 'Night theme is currently enabled.',
                style: const TextStyle(
                  color: AppTheme.subtleText,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'ABOUT',
            style: TextStyle(
              color: AppTheme.mutedGreen,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet_rounded,
                      color: AppTheme.primary,
                      size: 28,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Expense Tracker',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14),
                Text(
                  'Track your expenses, review spending by category, '
                  'and make smarter decisions about your money.',
                  style: TextStyle(
                    color: AppTheme.subtleText,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    color: AppTheme.mutedGreen,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
