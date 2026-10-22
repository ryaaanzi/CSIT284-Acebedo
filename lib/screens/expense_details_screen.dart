
import 'package:flutter/material.dart';

import '../models/expense.dart';

class ExpenseDetailsScreen extends StatelessWidget {
  const ExpenseDetailsScreen({
    super.key,
    required this.expense,
  });

  final Expense expense;

  String get _categoryName {
    switch (expense.category) {
      case Category.food:
        return 'Food';
      case Category.leisure:
        return 'Leisure';
      case Category.travel:
        return 'Travel';
      case Category.work:
        return 'Work';
    }
  }

  IconData get _categoryIcon {
    switch (expense.category) {
      case Category.food:
        return Icons.restaurant_rounded;
      case Category.leisure:
        return Icons.movie_rounded;
      case Category.travel:
        return Icons.directions_bus_rounded;
      case Category.work:
        return Icons.school_rounded;
    }
  }

  String get _formattedDate {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${months[expense.date.month - 1]} '
        '${expense.date.day}, ${expense.date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Details'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              CircleAvatar(
                radius: 42,
                backgroundColor: colorScheme.primaryContainer,
                child: Icon(
                  _categoryIcon,
                  size: 42,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                expense.title,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '₱${expense.amount.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineLarge?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _DetailRow(
                        icon: Icons.category_rounded,
                        label: 'Category',
                        value: _categoryName,
                      ),
                      const Divider(height: 32),
                      _DetailRow(
                        icon: Icons.calendar_month_rounded,
                        label: 'Date',
                        value: _formattedDate,
                      ),
                      const Divider(height: 32),
                      _DetailRow(
                        icon: Icons.payments_rounded,
                        label: 'Amount',
                        value: '₱${expense.amount.toStringAsFixed(2)}',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              OutlinedButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('Back to Dashboard'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          icon,
          color: theme.colorScheme.primary,
          size: 24,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.bodyLarge,
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
