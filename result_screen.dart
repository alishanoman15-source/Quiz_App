import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String userName;
  final int score;
  final int total;

  const ResultScreen({
    super.key,
    required this.userName,
    required this.score,
    required this.total,
  });

  // Score ke hisaab se message aur emoji
  String get _message {
    if (score == total) return 'Perfect Score! 🏆';
    if (score >= total * 0.8) return 'Excellent! 🌟';
    if (score >= total * 0.6) return 'Good Job! 👍';
    if (score >= total * 0.4) return 'Keep Practicing! 💪';
    return 'Try Again! 😅';
  }

  // Score ke hisaab se color
  Color get _scoreColor {
    if (score == total) return const Color(0xFFFFD700);
    if (score >= total * 0.8) return const Color(0xFF00E676);
    if (score >= total * 0.6) return const Color(0xFF40C4FF);
    if (score >= total * 0.4) return const Color(0xFFFFAB40);
    return const Color(0xFFFF5252);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // ── Trophy Icon ───────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.white.withOpacity(0.4), width: 2),
                  ),
                  child: Text(
                    score == total
                        ? '🏆'
                        : score >= total * 0.6
                            ? '🌟'
                            : '💪',
                    style: const TextStyle(fontSize: 64),
                  ),
                ),
                const SizedBox(height: 28),

                // ── Result Message ────────────────────────────────
                Text(
                  _message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Well done, $userName!',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 36),

                // ── Score Card ────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Your Score',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Big Score Number
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '$score',
                              style: TextStyle(
                                fontSize: 72,
                                fontWeight: FontWeight.bold,
                                color: _scoreColor,
                              ),
                            ),
                            TextSpan(
                              text: ' / $total',
                              style: const TextStyle(
                                fontSize: 32,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Progress bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: score / total,
                          minHeight: 12,
                          backgroundColor: const Color(0xFFEEEEEE),
                          valueColor:
                              AlwaysStoppedAnimation(_scoreColor),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Percentage
                      Text(
                        '${((score / total) * 100).toInt()}% Correct',
                        style: TextStyle(
                          fontSize: 15,
                          color: _scoreColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // ── Play Again Button ─────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Pehli screen par wapas jao
                      Navigator.popUntil(
                          context, (route) => route.isFirst);
                    },
                    icon: const Icon(Icons.replay, color: Colors.white),
                    label: const Text(
                      'Play Again 🔄',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF667EEA),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // ── Home Button ───────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.popUntil(
                          context, (route) => route.isFirst);
                    },
                    icon: const Icon(Icons.home, color: Colors.white),
                    label: const Text(
                      'Go to Home 🏠',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                          color: Colors.white, width: 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
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