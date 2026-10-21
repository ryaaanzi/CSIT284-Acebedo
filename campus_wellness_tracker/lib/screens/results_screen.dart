import 'package:flutter/material.dart';
import '../widgets/result_view.dart';

class ResultsScreen extends StatelessWidget {
  final int totalScore;
  final List<int> answers;

  const ResultsScreen({
    super.key,
    required this.totalScore,
    required this.answers,
  });

  String get _classification {
    if (totalScore >= 17) {
      return 'Healthy Balance';
    } else if (totalScore >= 11) {
      return 'Moderate Wellness Habits';
    } else {
      return 'Needs Improvement';
    }
  }

  String get _description {
    if (totalScore >= 17) {
      return 'Your answers suggest that you maintain several positive '
          'wellness habits. Keep building on these routines and maintain '
          'a healthy balance between school and personal life.';
    } else if (totalScore >= 11) {
      return 'You have some positive wellness habits, but there may be '
          'areas where you can improve. Small, consistent changes can '
          'help you develop a healthier routine.';
    } else {
      return 'Your answers suggest that some wellness habits may need '
          'more attention. Start with manageable changes and build '
          'healthier routines gradually.';
    }
  }

  String get _recommendation {
    if (totalScore >= 17) {
      return 'Maintain a consistent sleep schedule, stay hydrated, '
          'keep moving, take study breaks, and make time to relax. '
          'Continue checking in with yourself as your school routine changes.';
    } else if (totalScore >= 11) {
      return 'Choose one habit to improve this week. You could set a '
          'regular bedtime, keep a water bottle nearby, schedule short '
          'study breaks, or add a short walk to your day.';
    } else {
      return 'Start small: create a more consistent sleep routine, '
          'drink water regularly, take short breaks while studying, '
          'and reach out to someone you trust when you feel overwhelmed. '
          'Consider seeking campus support if you need additional help.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assessment Results'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 750;
            final result = ResultView(
              score: totalScore,
              maximumScore: 20,
              classification: _classification,
              description: _description,
              recommendation: _recommendation,
            );

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        size: 48,
                        color: colors.primary,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Assessment Complete!',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Here is a summary of your wellness check-in.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 28),
                      if (isWide)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: result),
                          ],
                        )
                      else
                        result,
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).popUntil(
                            (route) => route.isFirst,
                          );
                        },
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text('Restart Assessment'),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'This assessment is for general wellness awareness '
                        'and is not a medical diagnosis.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colors.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}