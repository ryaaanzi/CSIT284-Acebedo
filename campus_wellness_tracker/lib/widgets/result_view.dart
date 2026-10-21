import 'package:flutter/material.dart';

class ResultView extends StatelessWidget {
  final int score;
  final int maximumScore;
  final String classification;
  final String description;
  final String recommendation;

  const ResultView({
    super.key,
    required this.score,
    required this.maximumScore,
    required this.classification,
    required this.description,
    required this.recommendation,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final percentage = score / maximumScore;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                Icon(
                  Icons.health_and_safety_rounded,
                  size: 54,
                  color: colors.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Your Wellness Score',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  '$score / $maximumScore',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 18),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: percentage,
                    minHeight: 12,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '${(percentage * 100).round()}% of the maximum score',
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'YOUR CLASSIFICATION',
                  style: TextStyle(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  classification,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Card(
          color: colors.secondaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.lightbulb_outline_rounded,
                  color: colors.onSecondaryContainer,
                  size: 30,
                ),
                const SizedBox(height: 12),
                Text(
                  'RECOMMENDATION',
                  style: TextStyle(
                    color: colors.onSecondaryContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  recommendation,
                  style: TextStyle(
                    color: colors.onSecondaryContainer,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}