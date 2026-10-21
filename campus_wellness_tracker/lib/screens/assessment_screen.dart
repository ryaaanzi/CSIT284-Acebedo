
import 'package:flutter/material.dart';
import '../data/questions.dart';
import '../models/assessment_question.dart';
import '../widgets/answer_button.dart';
import '../widgets/question_card.dart';
import 'results_screen.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  int _currentIndex = 0;
  int _totalScore = 0;
  bool _isSubmitting = false;

  final List<int> _answers = [];

  AssessmentQuestion get _currentQuestion =>
      wellnessQuestions[_currentIndex];

  void _selectAnswer(AnswerOption option) {
    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
      _totalScore += option.score;
      _answers.add(option.score);
    });

    Future.delayed(const Duration(milliseconds: 250), () {
      if (!mounted) return;

      if (_currentIndex < wellnessQuestions.length - 1) {
        setState(() {
          _currentIndex++;
          _isSubmitting = false;
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResultsScreen(
              totalScore: _totalScore,
              answers: List.unmodifiable(_answers),
            ),
          ),
        );
      }
    });
  }

  Future<bool> _confirmExit() async {
    if (_answers.isEmpty) return true;

    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Leave assessment?'),
        content: const Text(
          'Your current assessment progress will be lost.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Continue Assessment'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Leave'),
          ),
        ],
      ),
    );

    if (!mounted) return false;

    return shouldExit ?? false;
  }

  Future<void> _handleExit() async {
    final shouldExit = await _confirmExit();

    if (!mounted || !shouldExit) return;

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final totalQuestions = wellnessQuestions.length;
    final progress = (_currentIndex + 1) / totalQuestions;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await _handleExit();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Wellness Assessment'),
          leading: IconButton(
            tooltip: 'Back',
            icon: const Icon(Icons.arrow_back),
            onPressed: _handleExit,
          ),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 700;

              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 760),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'YOUR WELLNESS CHECK-IN',
                              style: TextStyle(
                                color: colors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              '${_currentIndex + 1} / $totalQuestions',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: progress,
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        const SizedBox(height: 24),
                        QuestionCard(
                          question: _currentQuestion,
                          questionNumber: _currentIndex + 1,
                          totalQuestions: totalQuestions,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Choose the answer that best describes you:',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 14),
                        if (isWide)
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: _currentQuestion.options.map((option) {
                              return SizedBox(
                                width: (constraints.maxWidth - 60) / 2,
                                child: AnswerButton(
                                  option: option,
                                  onTap: () => _selectAnswer(option),
                                ),
                              );
                            }).toList(),
                          )
                        else
                          Column(
                            children: _currentQuestion.options.map((option) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 12),
                                child: AnswerButton(
                                  option: option,
                                  onTap: () => _selectAnswer(option),
                                ),
                              );
                            }).toList(),
                          ),
                        if (_isSubmitting) ...[
                          const SizedBox(height: 12),
                          const Center(
                            child:
                                CircularProgressIndicator.adaptive(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
