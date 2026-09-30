import 'package:flutter/material.dart';
import 'data/questions.dart';

void main() {
  runApp(const FoodFinderApp());
}

const backgroundTop = Color(0xFF24132F);
const backgroundBottom = Color(0xFF0F0915);
const primaryPink = Color(0xFFFF6B8A);
const lightPink = Color(0xFFFFA0B4);
const cardColor = Color(0xFF2B1A35);
const buttonColor = Color(0xFF3A2545);

class FoodFinderApp extends StatelessWidget {
  const FoodFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void startFinder(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const QuestionScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundTop,
              backgroundBottom,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: primaryPink.withOpacity(0.12),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: primaryPink.withOpacity(0.35),
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/main-logo.jfif',
                        width: 190,
                        height: 190,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Favorite Food Finder',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 31,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Answer three questions and discover a food that matches your preferences.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 34),
                  SizedBox(
                    width: 220,
                    height: 54,
                    child: ElevatedButton.icon(
                      onPressed: () => startFinder(context),
                      icon: const Icon(Icons.restaurant_rounded),
                      label: const Text('START'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryPink,
                        foregroundColor: Colors.white,
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  var currentQuestionIndex = 0;
  String? selectedAnswer;

  final List<String> selectedCategories = [];

  void selectAnswer(String answer, String category) {
    setState(() {
      selectedAnswer = answer;
      if (selectedCategories.length > currentQuestionIndex) {
        selectedCategories[currentQuestionIndex] = category;
      } else {
        selectedCategories.add(category);
      }
    });
  }

  void nextQuestion() {
    if (selectedAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an answer first.'),
        ),
      );
      return;
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
      });
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            selectedCategories: selectedCategories,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];
    final questionNumber = currentQuestionIndex + 1;
    final progress = questionNumber / questions.length;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundTop,
              backgroundBottom,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'FOOD FINDER',
                          style: TextStyle(
                            color: lightPink,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          'Question $questionNumber of ${questions.length}',
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 7,
                        backgroundColor: Colors.white10,
                        valueColor: const AlwaysStoppedAnimation(
                          primaryPink,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(22, 24, 22, 20),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 190,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          question.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 22),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: primaryPink.withOpacity(0.18),
                          ),
                        ),
                        child: Text(
                          question.text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            height: 1.35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ...question.answers.map(
                        (answer) {
                          final isSelected =
                              selectedAnswer == answer.text;

                          return FoodAnswerButton(
                            text: answer.text,
                            selected: isSelected,
                            onPressed: () {
                              selectAnswer(
                                answer.text,
                                answer.category,
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed: nextQuestion,
                          icon: Icon(
                            currentQuestionIndex ==
                                    questions.length - 1
                                ? Icons.check_rounded
                                : Icons.arrow_forward_rounded,
                          ),
                          label: Text(
                            currentQuestionIndex ==
                                    questions.length - 1
                                ? 'SEE MY RESULT'
                                : 'NEXT QUESTION',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryPink,
                            foregroundColor: Colors.white,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodAnswerButton extends StatelessWidget {
  const FoodAnswerButton({
    super.key,
    required this.text,
    required this.selected,
    required this.onPressed,
  });

  final String text;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              selected ? primaryPink.withOpacity(0.25) : buttonColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: selected
                  ? primaryPink
                  : Colors.white.withOpacity(0.08),
              width: selected ? 2 : 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              color: selected ? lightPink : Colors.white38,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.selectedCategories,
  });

  final List<String> selectedCategories;

  String get recommendedCategory {
    final scores = {
      'SL': 0,
      'SF': 0,
      'SE': 0,
      'HC': 0,
    };

    for (final category in selectedCategories) {
      scores[category] = scores[category]! + 1;
    }

    var highestCategory = 'SL';
    var highestScore = scores[highestCategory]!;

    for (final entry in scores.entries) {
      if (entry.value > highestScore) {
        highestCategory = entry.key;
        highestScore = entry.value;
      }
    }

    return highestCategory;
  }

  String get categoryName {
    switch (recommendedCategory) {
      case 'SL':
        return 'Sweet Lover';
      case 'SF':
        return 'Savory Fan';
      case 'SE':
        return 'Spicy Explorer';
      case 'HC':
        return 'Healthy Choice';
      default:
        return 'Food Lover';
    }
  }

  String get categoryDescription {
    switch (recommendedCategory) {
      case 'SL':
        return 'You enjoy desserts, sweet flavors, and sugary treats.';
      case 'SF':
        return 'You enjoy salty, savory, and flavorful foods.';
      case 'SE':
        return 'You like bold flavors and foods with a kick.';
      case 'HC':
        return 'You prefer lighter and healthier meal choices.';
      default:
        return 'You have a great taste in food.';
    }
  }

  String get categoryImage {
    switch (recommendedCategory) {
      case 'SL':
        return 'assets/images/a-sweets.webp';
      case 'SF':
        return 'assets/images/a-savory.jpg';
      case 'SE':
        return 'assets/images/a-spicy.jpg';
      case 'HC':
        return 'assets/images/a-healthy.jpg';
      default:
        return 'assets/images/a-sweets.webp';
    }
  }

  void tryAgain(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundTop,
              backgroundBottom,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 25,
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.restaurant_menu_rounded,
                  color: lightPink,
                  size: 54,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Your Recommended Food Type',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: primaryPink.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          categoryImage,
                          width: double.infinity,
                          height: 210,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Recommended Category',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        categoryName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: lightPink,
                          fontSize: 29,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        categoryDescription,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: 220,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () => tryAgain(context),
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('TRY AGAIN'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryPink,
                      foregroundColor: Colors.white,
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}