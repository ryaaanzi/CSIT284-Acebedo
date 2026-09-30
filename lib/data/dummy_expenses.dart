import '../models/expense.dart';

final List<Expense> dummyExpenses = [
  Expense(
    title: 'Lunch',
    amount: 180,
    date: DateTime.now().subtract(const Duration(days: 1)),
    category: Category.food,
  ),
  Expense(
    title: 'Coffee',
    amount: 120,
    date: DateTime.now().subtract(const Duration(days: 2)),
    category: Category.food,
  ),
  Expense(
    title: 'Movie Night',
    amount: 450,
    date: DateTime.now().subtract(const Duration(days: 3)),
    category: Category.leisure,
  ),
  Expense(
    title: 'Bus Fare',
    amount: 75,
    date: DateTime.now().subtract(const Duration(days: 4)),
    category: Category.travel,
  ),
  Expense(
    title: 'School Supplies',
    amount: 320,
    date: DateTime.now().subtract(const Duration(days: 5)),
    category: Category.work,
  ),
];