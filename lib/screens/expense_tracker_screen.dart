import 'package:flutter/material.dart';

import '../data/dummy_expenses.dart';
import '../models/expense.dart';
import '../theme/app_theme.dart';
import '../widgets/background_glow.dart';
import '../widgets/expenses/expense_item.dart';
import '../widgets/forms/add_expense_sheet.dart';
import '../widgets/glass_card.dart';

class ExpenseTrackerScreen extends StatefulWidget {
  const ExpenseTrackerScreen({
    required this.forestMode,
    required this.onThemeChanged,
    super.key,
  });

  final bool forestMode;
  final VoidCallback onThemeChanged;

  @override
  State<ExpenseTrackerScreen> createState() => _ExpenseTrackerScreenState();
}

class _ExpenseTrackerScreenState extends State<ExpenseTrackerScreen> {
  double get totalExpenses {
    return dummyExpenses.fold<double>(
      0,
      (sum, expense) => sum + expense.amount,
    );
  }

  Map<Category, double> get categoryTotals {
    final totals = <Category, double>{
      for (final category in Category.values) category: 0,
    };

    for (final expense in dummyExpenses) {
      totals[expense.category] =
          (totals[expense.category] ?? 0) + expense.amount;
    }

    return totals;
  }

  IconData getCategoryIcon(Category category) {
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

  Color getCategoryColor(Category category) {
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

  String formatCategory(Category category) {
    return category.name[0].toUpperCase() + category.name.substring(1);
  }

  String formatDate(DateTime date) {
    return '${date.month.toString().padLeft(2, '0')}/'
        '${date.day.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  void _openAddExpenseSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return const AddExpenseSheet();
      },
    ).then((_) {
      setState(() {});
    });
  }

  void _removeExpense(Expense expense) {
    final removedIndex = dummyExpenses.indexOf(expense);

    setState(() {
      dummyExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF17321F),
        content: Text(
          '${expense.title} deleted.',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: AppTheme.primary,
          onPressed: () {
            setState(() {
              dummyExpenses.insert(removedIndex, expense);
            });
          },
        ),
      ),
    );
  }

 @override
Widget build(BuildContext context) {
      final mediaQuery = MediaQuery.of(context);
      final screenWidth = mediaQuery.size.width;
      final isLandscape = mediaQuery.orientation == Orientation.landscape;
      final isWideScreen = screenWidth >= 600 || isLandscape;

  return Stack(
      children: [
        const BackgroundGlow(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            titleSpacing: 20,
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Expense Tracker',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Track it. Spend smarter.',
                  style: TextStyle(
                    color: AppTheme.subtleText,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: widget.onThemeChanged,
                tooltip: widget.forestMode
                    ? 'Switch to Night Mode'
                    : 'Switch to Forest Mode',
                icon: Icon(
                  widget.forestMode
                      ? Icons.nightlight_round
                      : Icons.forest_rounded,
                  color: AppTheme.primary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: IconButton(
                  onPressed: _openAddExpenseSheet,
                  tooltip: 'Add Expense',
                  icon: Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primary.withValues(alpha: 0.25),
                          blurRadius: 16,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      color: AppTheme.background,
                    ),
                  ),
                ),
              ),
            ],
          ),
         body: isWideScreen
    ? Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                       padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    _buildSummaryCard(),
                    const SizedBox(height: 12),
                    _buildCategoryOverview(),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: dummyExpenses.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 110),
                      itemCount: dummyExpenses.length,
                      itemBuilder: (context, index) {
                        final expense = dummyExpenses[index];

                        return TweenAnimationBuilder<double>(
                          duration: Duration(
                            milliseconds: 300 + (index * 60),
                          ),
                          tween: Tween(begin: 0, end: 1),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(
                                  0,
                                  18 * (1 - value),
                                ),
                                child: child,
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _buildExpenseItem(expense),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      )
    : Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
            child: Column(
              children: [
                _buildSummaryCard(),
                const SizedBox(height: 12),
                _buildCategoryOverview(),
              ],
            ),
          ),
          Expanded(
            child: dummyExpenses.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      0,
                      16,
                      110,
                    ),
                    itemCount: dummyExpenses.length,
                    itemBuilder: (context, index) {
                      final expense = dummyExpenses[index];

                      return TweenAnimationBuilder<double>(
                        duration: Duration(
                          milliseconds: 300 + (index * 60),
                        ),
                        tween: Tween(begin: 0, end: 1),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(
                                0,
                                18 * (1 - value),
                              ),
                              child: child,
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildExpenseItem(expense),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: _openAddExpenseSheet,
            backgroundColor: AppTheme.primary,
            foregroundColor: AppTheme.background,
            elevation: 8,
            icon: const Icon(Icons.add_rounded),
            label: const Text(
              'Add Expense',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AppTheme.primary.withValues(alpha: 0.18),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primary.withValues(alpha: 0.16),
            AppTheme.surface,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: 0.10),
            blurRadius: 30,
            spreadRadius: -5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.13),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_rounded,
                  color: AppTheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'TOTAL SPENDING',
                style: TextStyle(
                  color: AppTheme.mutedGreen,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 17),
          Text(
            '₱${totalExpenses.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.2,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${dummyExpenses.length} recorded '
            '${dummyExpenses.length == 1 ? 'expense' : 'expenses'}',
            style: const TextStyle(
              color: AppTheme.subtleText,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryOverview() {
    final totals = categoryTotals;

    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SPENDING BY CATEGORY',
              style: TextStyle(
                color: AppTheme.mutedGreen,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            ...Category.values.map((category) {
              final amount = totals[category] ?? 0;
              final percentage =
                  totalExpenses == 0 ? 0.0 : amount / totalExpenses;

              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _buildCategoryRow(
                  category,
                  amount,
                  percentage,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryRow(
    Category category,
    double amount,
    double percentage,
  ) {
    final color = getCategoryColor(category);

    return Column(
      children: [
        Row(
          children: [
            Icon(
              getCategoryIcon(category),
              color: color,
              size: 17,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                formatCategory(category),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              '₱${amount.toStringAsFixed(0)}',
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 5,
            backgroundColor: const Color(0xFF1B3022),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  Widget _buildExpenseItem(Expense expense) {
    return ExpenseItem(
      expense: expense,
      categoryColor: getCategoryColor(expense.category),
      categoryIcon: getCategoryIcon(expense.category),
      categoryName: formatCategory(expense.category),
      formattedDate: formatDate(expense.date),
      onDismissed: () {
        _removeExpense(expense);
      },
      dismissBackground: _buildDismissBackground,
    );
  }

  Widget _buildDismissBackground(bool left) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF321719),
        borderRadius: BorderRadius.circular(18),
      ),
      alignment: left ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete_outline_rounded,
        color: Color(0xFFFF7676),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.primary.withValues(alpha: 0.15),
                ),
              ),
              child: const Icon(
                Icons.receipt_long_rounded,
                size: 42,
                color: AppTheme.primary,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Nothing here yet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add your first expense and start tracking where your money goes.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.subtleText,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}