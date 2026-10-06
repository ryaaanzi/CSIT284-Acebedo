import 'package:flutter/material.dart';

import '../../models/expense.dart';
import '../../theme/app_theme.dart';
import '../glass_card.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({
    required this.expense,
    required this.categoryColor,
    required this.categoryIcon,
    required this.categoryName,
    required this.formattedDate,
    required this.onDismissed,
    required this.dismissBackground,
    super.key,
  });

  final Expense expense;
  final Color categoryColor;
  final IconData categoryIcon;
  final String categoryName;
  final String formattedDate;
  final VoidCallback onDismissed;
  final Widget Function(bool left) dismissBackground;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(expense),
      direction: DismissDirection.horizontal,
      background: dismissBackground(true),
      secondaryBackground: dismissBackground(false),
      onDismissed: (_) {
        onDismissed();
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
                  categoryIcon,
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
                          categoryName,
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
                          formattedDate,
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
                  color: AppTheme.softGreen,
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
}