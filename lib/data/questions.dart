import '../models/quiz_question.dart';

const questions = [
  QuizQuestion(
    text: 'What flavor do you enjoy most?',
    answers: [
      'Sweet (SL)',
      'Salty (SF) ',
      'Spicy (SE) ',
      'Sour (SF) ',
    ],
    correctAnswer: 'The UI is not updated',
  ),
  QuizQuestion(
    text: 'Which widget is used when the UI can change over time?',
    answers: [
      'StatelessWidget',
      'StatefulWidget',
      'Container',
      'MaterialApp',
    ],
    correctAnswer: 'StatefulWidget',
  ),
  QuizQuestion(
    text: 'Which method is used to rebuild a StatefulWidget?',
    answers: [
      'build()',
      'setState()',
      'createState()',
      'initState()',
    ],
    correctAnswer: 'setState()',
  ),
  QuizQuestion(
    text: 'What language is used to build Flutter apps?',
    answers: [
      'Java',
      'C++',
      'Dart',
      'Python',
    ],
    correctAnswer: 'Dart',
  ),
];