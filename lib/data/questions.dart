import '../models/quiz_question.dart';

const questions = [
  QuizQuestion(
    text: 'What happens if you change data in a StatelessWidget?',
    answers: [
      'The closest StatefulWidget is updated',
      'The UI is updated',
      'Any nested StatefulWidgets are updated',
      'The UI is not updated',
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