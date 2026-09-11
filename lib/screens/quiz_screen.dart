import 'package:flutter/material.dart';
import 'result_screen.dart';
import '../data/questions.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int? selectedAnswer;
  int correctAnswers = 0;


  void nextQuestion() {
  if (selectedAnswer == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pilih jawaban terlebih dahulu!'),
      ),
    );
    return;
  }

  // Cek jawaban
  if (selectedAnswer == questions[currentQuestion]['correct']) {
    correctAnswers++;
  }

  // Masih ada soal
  if (currentQuestion < questions.length - 1) {
    setState(() {
      currentQuestion++;
      selectedAnswer = null;
    });
  } else {
    // Semua soal selesai
    final int score =
        ((correctAnswers / questions.length) * 100).round();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          score: score,
          totalQuestions: questions.length,
          correctAnswers: correctAnswers,
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            child: Column(
              children: [

                // ==========================================
                // HEADER
                // ==========================================

                Container(
                  height: 62,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFF00518A),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(28),
                    ),
                  ),
                  child: Row(
                    children: [

                      // Tombol kembali
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),

                      const SizedBox(width: 12),

                      const Text(
                        'E-Quiz',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const Spacer(),

                      const Icon(
                        Icons.bolt_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ],
                  ),
                ),

                // ==========================================
                // CONTENT
                // ==========================================

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        // ==================================
                        // PROGRESS
                        // ==================================

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'PERTANYAAN '
                              '${currentQuestion + 1} / ${questions.length}',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF00518A),
                              ),
                            ),

                            Text(
                              '${((currentQuestion + 1) / questions.length * 100).round()}%',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // Progress bar
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value:
                                (currentQuestion + 1) /
                                    questions.length,
                            minHeight: 7,
                            backgroundColor:
                                Colors.grey.shade200,
                            valueColor:
                                const AlwaysStoppedAnimation(
                              Color(0xFF00518A),
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),

                        // ==================================
                        // CATEGORY
                        // ==================================

                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD000)
                                .withOpacity(0.25),
                            borderRadius:
                                BorderRadius.circular(20),
                          ),
                          child: Text(
                            question['category'],
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF806A00),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // ==================================
                        // QUESTION CARD
                        // ==================================

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.06),
                                blurRadius: 15,
                                offset:
                                    const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Text(
                            question['question'],
                            style: const TextStyle(
                              fontSize: 18,
                              height: 1.4,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF123B58),
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        // ==================================
                        // JAWABAN
                        // ==================================

                        ...List.generate(
                          question['answers'].length,
                          (index) {
                            return _buildAnswer(
                              index,
                              question['answers'][index],
                            );
                          },
                        ),

                        const SizedBox(height: 15),

                        // ==================================
                        // TOMBOL LANJUT
                        // ==================================

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: nextQuestion,
                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF00518A),
                              foregroundColor:
                                  Colors.white,
                              elevation: 3,
                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                  28,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Text(
                                  currentQuestion ==
                                          questions.length - 1
                                      ? 'Selesai'
                                      : 'Lanjut',
                                  style: const TextStyle(
                                    fontWeight:
                                        FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons
                                      .arrow_forward_rounded,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
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

  // ==========================================
  // ANSWER OPTION
  // ==========================================

  Widget _buildAnswer(
    int index,
    String answer,
  ) {
    final bool selected = selectedAnswer == index;

    final letters = ['A', 'B', 'C', 'D'];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAnswer = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 11),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFEAF5FC)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected
                ? const Color(0xFF00518A)
                : Colors.grey.shade200,
            width: selected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [

            // Huruf A B C D
            Container(
              width: 35,
              height: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF00518A)
                    : const Color(0xFFF1F3F6),
                shape: BoxShape.circle,
              ),
              child: Text(
                letters[index],
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: selected
                      ? Colors.white
                      : const Color(0xFF555555),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Jawaban
            Expanded(
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: selected
                      ? FontWeight.w700
                      : FontWeight.w500,
                  color: const Color(0xFF333333),
                ),
              ),
            ),

            // Radio
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? const Color(0xFF00518A)
                      : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration:
                            const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF00518A),
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}