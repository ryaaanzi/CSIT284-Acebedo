
class AnswerOption {
  final String text;
  final int score;

  const AnswerOption({
    required this.text,
    required this.score,
  });
}

class AssessmentQuestion {
  final String question;
  final String description;
  final String category;
  final String? iconAsset;
  final List<AnswerOption> options;

  const AssessmentQuestion({
    required this.question,
    required this.description,
    required this.category,
    this.iconAsset,
    required this.options,
  });
}
