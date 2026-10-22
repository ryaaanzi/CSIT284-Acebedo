
import 'package:flutter/material.dart';

import '../data/dummy_expenses.dart';
import '../models/expense.dart';
import '../theme/app_theme.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  Color _categoryColor(Category category) {
    switch (category) {
      case Category.food:
        return const Color(0xFFFFB86B);
      case Category.leisure:
        return const Color(0xFFB99CFF);
      case Category.travel:
        return const Color(0xFF6ED8FF);
      case Category.work:
        return AppTheme.primary;
    }
  }

  IconData _categoryIcon(Category category) {
    switch (category) {
      case Category.food:
        return Icons.restaurant_rounded;
      case Category.leisure:
        return Icons.movie_rounded;
      case Category.travel:
        return Icons.directions_bus_rounded;
      case Category.work:
        return Icons.work_rounded;
    }
  }

  String _categoryName(Category category) {
    return category.name[0].toUpperCase() +
        category.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final total = dummyExpenses.fold<double>(
      0,
      (sum, expense) => sum + expense.amount,
    );

    final count = dummyExpenses.length;
    final average = count == 0 ? 0.0 : total / count;

    final totals = <Category, double>{
      for (final category in Category.values) category: 0,
    };

    for (final expense in dummyExpenses) {
      totals[expense.category] =
          (totals[expense.category] ?? 0) + expense.amount;
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text(
          'Statistics',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'YOUR SPENDING OVERVIEW',
              style: TextStyle(
                color: AppTheme.mutedGreen,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.primary.withValues(alpha: 0.18),
                    AppTheme.surface,
                  ],
                ),
                border: Border.all(
                  color: AppTheme.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.account_balance_wallet_rounded,
                    color: AppTheme.primary,
                    size: 28,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'TOTAL SPENDING',
                    style: TextStyle(
                      color: AppTheme.mutedGreen,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '₱${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _summaryCard(
                    icon: Icons.receipt_long_rounded,
                    label: 'EXPENSES',
                    value: '$count',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _summaryCard(
                    icon: Icons.calculate_rounded,
                    label: 'AVERAGE',
                    value: '₱${average.toStringAsFixed(2)}',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            const Text(
              'CATEGORY BREAKDOWN',
              style: TextStyle(
                color: AppTheme.mutedGreen,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 14),
            ...Category.values.map((category) {
              final amount = totals[category] ?? 0;
              final fraction = total == 0 ? 0.0 : amount / total;
              final color = _categoryColor(category);

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          _categoryIcon(category),
                          color: color,
                          size: 21,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _categoryName(category),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          '₱${amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: fraction,
                        minHeight: 6,
                        backgroundColor: const Color(0xFF1B3022),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(color),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${(fraction * 100).toStringAsFixed(1)}% of spending',
                        style: const TextStyle(
                          color: AppTheme.subtleText,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 12),
            const Text(
              'Statistics are calculated from the expenses currently recorded in the app.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.subtleText,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.primary, size: 22),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              color: AppTheme.subtleText,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
