import '../models/quiz_question.dart';

const questions = [
  QuizQuestion(
    text: 'What flavor do you enjoy most?',
    image: 'assets/images/q-flavors.jfif',
    answers: [
      QuizAnswer(
        text: 'Sweet',
        category: 'SL',
      ),
      QuizAnswer(
        text: 'Salty',
        category: 'SF',
      ),
      QuizAnswer(
        text: 'Spicy',
        category: 'SE',
      ),
      QuizAnswer(
        text: 'Sour',
        category: 'SF',
      ),
    ],
  ),
  QuizQuestion(
    text: 'Which snack would you choose?',
    image: 'assets/images/q-snacks.jfif',
    answers: [
      QuizAnswer(
        text: 'Cake',
        category: 'SL',
      ),
      QuizAnswer(
        text: 'Fries',
        category: 'SF',
      ),
      QuizAnswer(
        text: 'Nachos',
        category: 'SF',
      ),
      QuizAnswer(
        text: 'Fruit',
        category: 'HC',
      ),
    ],
  ),
  QuizQuestion(
    text: 'What would you most likely order at a restaurant?',
    image: 'assets/images/q-restaurant.jpg',
    answers: [
      QuizAnswer(
        text: 'Dessert',
        category: 'SL',
      ),
      QuizAnswer(
        text: 'Burger',
        category: 'SF',
      ),
      QuizAnswer(
        text: 'Chicken Wings',
        category: 'SE',
      ),
      QuizAnswer(
        text: 'Salad',
        category: 'HC',
      ),
    ],
  ),
];