
import 'package:flutter/material.dart';
import '../models/assessment_question.dart';

class QuestionCard extends StatelessWidget {
  final AssessmentQuestion question;
  final int questionNumber;
  final int totalQuestions;

  const QuestionCard({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (question.iconAsset != null)
                    Image.asset(
                      question.iconAsset!,
                      width: 20,
                      height: 20,
                      color: colors.onPrimaryContainer,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.favorite_outline_rounded,
                          size: 20,
                          color: colors.onPrimaryContainer,
                        );
                      },
                    )
                  else
                    Icon(
                      Icons.coffee_rounded,
                      size: 20,
                      color: colors.onPrimaryContainer,
                    ),
                  const SizedBox(width: 8),
                  Text(
                    question.category,
                    style: TextStyle(
                      color: colors.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Text(
              'Question $questionNumber of $totalQuestions',
              style: TextStyle(
                color: colors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              question.question,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              question.description,
              style: TextStyle(
                color: colors.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
