import 'dart:ui';

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
    const background = Color(0xFF06110B);
    const surface = Color(0xFF0B1C12);
    const green = Color(0xFF78FF8A);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: background,
        colorScheme: const ColorScheme.dark(
          primary: green,
          secondary: green,
          surface: surface,
          onPrimary: Color(0xFF06110B),
          onSecondary: Color(0xFF06110B),
          onSurface: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF102319),
          labelStyle: const TextStyle(
            color: Color(0xFF9CB4A2),
          ),
          hintStyle: const TextStyle(
            color: Color(0xFF65796B),
          ),
          prefixIconColor: green,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xFF24422D),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color(0xFF24422D),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: green,
              width: 1.5,
            ),
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            color: Color(0xFFA7B8AC),
          ),
        ),
      ),
      home: const ExpenseTrackerScreen(),
    );
  }
}

class ExpenseTrackerScreen extends StatefulWidget {
  const ExpenseTrackerScreen({super.key});

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
        return const Color(0xFF78FF8A);
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
          textColor: const Color(0xFF78FF8A),
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
    return Stack(
      children: [
        const _BackgroundGlow(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
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
                    color: Color(0xFF789181),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: IconButton(
                  onPressed: _openAddExpenseSheet,
                  tooltip: 'Add Expense',
                  icon: Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: const Color(0xFF78FF8A),
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF78FF8A)
                              .withValues(alpha: 0.25),
                          blurRadius: 16,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      color: Color(0xFF06110B),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Column(
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
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 110),
                        itemCount: dummyExpenses.length,
                        itemBuilder: (context, index) {
                          final expense = dummyExpenses[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _buildExpenseItem(expense),
                          );
                        },
                      ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: _openAddExpenseSheet,
            backgroundColor: const Color(0xFF78FF8A),
            foregroundColor: const Color(0xFF06110B),
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
          color: const Color(0xFF78FF8A).withValues(alpha: 0.18),
        ),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF163B24),
            Color(0xFF0B2114),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF78FF8A).withValues(alpha: 0.10),
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
                  color: const Color(0xFF78FF8A).withValues(alpha: 0.13),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_rounded,
                  color: Color(0xFF78FF8A),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'TOTAL SPENDING',
                style: TextStyle(
                  color: Color(0xFF83A18D),
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
              color: Color(0xFF7F9988),
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
                color: Color(0xFF83A18D),
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
    final categoryColor = getCategoryColor(expense.category);

    return Dismissible(
      key: ObjectKey(expense),
      direction: DismissDirection.horizontal,
      background: _buildDismissBackground(true),
      secondaryBackground: _buildDismissBackground(false),
      onDismissed: (_) {
        _removeExpense(expense);
      },
      child: GlassCard(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: categoryColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: categoryColor.withValues(alpha: 0.16),
                  ),
                ),
                child: Icon(
                  getCategoryIcon(expense.category),
                  color: categoryColor,
                  size: 23,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expense.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          formatCategory(expense.category),
                          style: TextStyle(
                            color: categoryColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Text(
                          '  •  ',
                          style: TextStyle(
                            color: Color(0xFF506258),
                          ),
                        ),
                        Text(
                          formatDate(expense.date),
                          style: const TextStyle(
                            color: Color(0xFF73877A),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '₱${expense.amount.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Color(0xFFB8FFC0),
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
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
                color: const Color(0xFF78FF8A).withValues(alpha: 0.08),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF78FF8A).withValues(alpha: 0.15),
                ),
              ),
              child: const Icon(
                Icons.receipt_long_rounded,
                size: 42,
                color: Color(0xFF78FF8A),
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
                color: Color(0xFF718579),
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GlassCard extends StatelessWidget {
  const GlassCard({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 12,
          sigmaY: 12,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF102319).withValues(alpha: 0.82),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFF78FF8A).withValues(alpha: 0.10),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _BackgroundGlow extends StatelessWidget {
  const _BackgroundGlow();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -120,
            right: -100,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF35FF62).withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            top: 260,
            left: -160,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF0AFF62).withValues(alpha: 0.035),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddExpenseSheet extends StatefulWidget {
  const AddExpenseSheet({super.key});

  @override
  State<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends State<AddExpenseSheet> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  Category _selectedCategory = Category.food;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF78FF8A),
              onPrimary: Color(0xFF06110B),
              surface: Color(0xFF102319),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate == null) {
      return;
    }

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _saveExpense() {
    final title = _titleController.text.trim();
    final amount = double.tryParse(_amountController.text.trim());

    if (title.isEmpty || amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xFF321719),
          content: Text(
            'Please enter a valid title and amount.',
          ),
        ),
      );
      return;
    }

    dummyExpenses.add(
      Expense(
        title: title,
        amount: amount,
        date: _selectedDate,
        category: _selectedCategory,
      ),
    );

    Navigator.of(context).pop();
  }

  String formatDate(DateTime date) {
    return '${date.month.toString().padLeft(2, '0')}/'
        '${date.day.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0B1C12),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          12,
          16,
          bottomInset + 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF34503D),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const Text(
                'Add Expense',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Record where your money went.',
                style: TextStyle(
                  color: Color(0xFF718579),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 22),
              TextField(
                controller: _titleController,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Expense Title',
                  hintText: 'e.g. Lunch',
                  prefixIcon: Icon(Icons.edit_rounded),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  hintText: 'e.g. 250.00',
                  prefixIcon: Icon(Icons.payments_rounded),
                  prefixText: '₱ ',
                ),
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<Category>(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  prefixIcon: Icon(Icons.category_rounded),
                ),
                items: Category.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(
                      category.name[0].toUpperCase() +
                          category.name.substring(1),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Date: ${formatDate(_selectedDate)}',
                      style: const TextStyle(
                        color: Color(0xFFA7B8AC),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: _selectDate,
                    icon: const Icon(Icons.calendar_month_rounded),
                    label: const Text('Date'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF78FF8A),
                      side: const BorderSide(
                        color: Color(0xFF34503D),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 52,
                child: FilledButton.icon(
                  onPressed: _saveExpense,
                  icon: const Icon(Icons.check_rounded),
                  label: const Text(
                    'Save Expense',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF78FF8A),
                    foregroundColor: const Color(0xFF06110B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}