class QuizAnswer {
  const QuizAnswer({
    required this.text,
    required this.category,
  });

  final String text;
  final String category;
}

class QuizQuestion {
  const QuizQuestion({
    required this.text,
    required this.image,
    required this.answers,
  });

  final String text;
  final String image;
  final List<QuizAnswer> answers;
}