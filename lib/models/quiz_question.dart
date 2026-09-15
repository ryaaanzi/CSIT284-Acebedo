class QuizQuestion {
  const QuizQuestion({
    required this.text,
    required this.answers,
    required this.correctAnswer,
  });

  final String text;
  final List<String> answers;
  final String correctAnswer;
}