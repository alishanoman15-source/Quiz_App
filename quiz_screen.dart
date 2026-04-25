import 'package:flutter/material.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String userName;
  const QuizScreen({super.key, required this.userName});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // Current question index
  int _currentIndex = 0;

  // Score counter
  int _score = 0;

  // Selected answer
  String? _selectedAnswer;

  // Questions list
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What language does Flutter use?',
      'options': ['Java', 'Dart', 'Kotlin', 'Swift'],
      'answer': 'Dart',
      'icon': '💻',
    },
    {
      'question': 'Which widget has NO state in Flutter?',
      'options': ['StatefulWidget', 'StatelessWidget', 'Container', 'Scaffold'],
      'answer': 'StatelessWidget',
      'icon': '🧩',
    },
    {
      'question': 'What does Navigator.pop() do?',
      'options': [
        'Opens new screen',
        'Closes app',
        'Goes back to previous screen',
        'Refreshes screen'
      ],
      'answer': 'Goes back to previous screen',
      'icon': '🧭',
    },
    {
      'question': 'Which widget scrolls a list in Flutter?',
      'options': ['Column', 'Row', 'ListView', 'Stack'],
      'answer': 'ListView',
      'icon': '📜',
    },
    {
      'question': 'What is hot reload in Flutter?',
      'options': [
        'Restart phone',
        'See changes instantly without restart',
        'Delete app',
        'Install app'
      ],
      'answer': 'See changes instantly without restart',
      'icon': '🔥',
    },
  ];

  // Next button OR submit
  void _nextQuestion() {
    if (_selectedAnswer == null) return;

    // Check answer
    if (_selectedAnswer == _questions[_currentIndex]['answer']) {
      _score++;
    }

    // Last question?
    if (_currentIndex == _questions.length - 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            userName: widget.userName,
            score: _score,
            total: _questions.length,
          ),
        ),
      );
    } else {
      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
      });
    }
  }

  // ✅ Back to previous question
  void _previousQuestion() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _selectedAnswer = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentIndex];
    final progress = (_currentIndex + 1) / _questions.length;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF11998E), Color(0xFF38EF7D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

                // ── Top Bar ──────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back to previous question button
                    GestureDetector(
                      onTap: _previousQuestion,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(
                              _currentIndex > 0 ? 0.3 : 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.arrow_back_ios_new,
                            color: Colors.white.withOpacity(
                                _currentIndex > 0 ? 1.0 : 0.3),
                            size: 20),
                      ),
                    ),

                    // Question counter
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Q ${_currentIndex + 1} / ${_questions.length}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),

                    // Score badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '⭐ $_score',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // ── Progress Bar ─────────────────────────────────
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
                const SizedBox(height: 24),

                // ── Question Card ─────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(question['icon'],
                          style: const TextStyle(fontSize: 48)),
                      const SizedBox(height: 16),
                      Text(
                        question['question'],
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF222222)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Options ───────────────────────────────────────
                Expanded(
                  child: ListView(
                    children: (question['options'] as List<String>)
                        .map((option) {
                      final isSelected = _selectedAnswer == option;
                      return GestureDetector(
                        onTap: () {
                          setState(() => _selectedAnswer = option);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF11998E)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF11998E)
                                  : Colors.white,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.07),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              // Circle indicator
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFFEEEEEE),
                                ),
                                child: isSelected
                                    ? const Icon(Icons.check,
                                        color: Color(0xFF11998E), size: 18)
                                    : null,
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF333333),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                // ── Next Button ───────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _selectedAnswer != null ? _nextQuestion : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF222222),
                      disabledBackgroundColor:
                          Colors.black.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(
                      _currentIndex == _questions.length - 1
                          ? 'Submit Quiz ✅'
                          : 'Next Question →',
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}