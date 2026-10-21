
import '../models/assessment_question.dart';

const List<AssessmentQuestion> wellnessQuestions = [
  AssessmentQuestion(
    category: 'Sleep',
    iconAsset: 'assets/icons/bedtime.png',
    question: 'How would you describe your sleep schedule?',
    description: 'Think about your usual sleep routine on school days.',
    options: [
      AnswerOption(text: 'Less than 5 hours', score: 1),
      AnswerOption(text: '5–6 hours', score: 2),
      AnswerOption(text: '7–8 hours', score: 4),
      AnswerOption(text: 'More than 8 hours', score: 3),
    ],
  ),
  AssessmentQuestion(
    category: 'Breaks',
    question: 'How often do you take breaks while studying?',
    description: 'Consider how you balance studying and resting.',
    options: [
      AnswerOption(text: 'Almost never', score: 1),
      AnswerOption(text: 'Only when I feel tired', score: 2),
      AnswerOption(text: 'Every few hours', score: 3),
      AnswerOption(text: 'Regularly throughout studying', score: 4),
    ],
  ),
  AssessmentQuestion(
    category: 'Physical Activity',
    iconAsset: 'assets/icons/fitness_center.png',
    question: 'How often do you engage in physical activity?',
    description: 'Include walking, exercise, sports, or other movement.',
    options: [
      AnswerOption(text: 'Rarely or never', score: 1),
      AnswerOption(text: 'Once a week', score: 2),
      AnswerOption(text: '2–3 times a week', score: 3),
      AnswerOption(text: '4 or more times a week', score: 4),
    ],
  ),
  AssessmentQuestion(
    category: 'Hydration',
    iconAsset: 'assets/icons/water_drop.png',
    question: 'How often do you drink water during the day?',
    description: 'Think about your hydration habits while at school.',
    options: [
      AnswerOption(text: 'I often forget to drink water', score: 1),
      AnswerOption(text: 'Only when I feel thirsty', score: 2),
      AnswerOption(text: 'Several times a day', score: 3),
      AnswerOption(text: 'Regularly throughout the day', score: 4),
    ],
  ),
  AssessmentQuestion(
    category: 'Stress Management',
    iconAsset: 'assets/icons/stress_management.png',
    question: 'How do you usually handle school-related stress?',
    description: 'Choose the answer that best describes your usual habits.',
    options: [
      AnswerOption(text: 'I feel overwhelmed most of the time', score: 1),
      AnswerOption(text: 'I struggle to manage my stress', score: 2),
      AnswerOption(text: 'I manage it reasonably well', score: 3),
      AnswerOption(text: 'I use healthy ways to manage stress', score: 4),
    ],
  ),
];
