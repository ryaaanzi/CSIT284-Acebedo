import 'package:flutter/material.dart';

import 'data/dummy_expenses.dart';
import 'models/expense.dart';

void main() {
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B5BD6),
        ),
        useMaterial3: true,
      ),
      home: const ExpenseTrackerScreen(),
    );
  }
}

class ExpenseTrackerScreen extends StatelessWidget {
  const ExpenseTrackerScreen({super.key});

  IconData getCategoryIcon(Category category) {
    switch (category) {
      case Category.food:
        return Icons.restaurant;
      case Category.leisure:
        return Icons.movie;
      case Category.travel:
        return Icons.directions_bus;
      case Category.work:
        return Icons.work;
    }
  }

  String formatDate(DateTime date) {
    return '${date.month.toString().padLeft(2, '0')}/'
        '${date.day.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  double get totalExpenses {
    return dummyExpenses.fold(
      0,
      (sum, expense) => sum + expense.amount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense Tracker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Expenses',
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimaryContainer,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '₱${totalExpenses.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimaryContainer,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: dummyExpenses.length,
              itemBuilder: (context, index) {
                final expense = dummyExpenses[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            getCategoryIcon(expense.category),
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                expense.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${expense.category.name.toUpperCase()} • '
                                '${formatDate(expense.date)}',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '₱${expense.amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}