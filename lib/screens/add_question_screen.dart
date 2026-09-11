import 'package:flutter/material.dart';

class AddQuestionScreen extends StatefulWidget {
  final Map<String, dynamic>? question;

  const AddQuestionScreen({
    super.key,
    this.question,
  });

  @override
  State<AddQuestionScreen> createState() =>
      _AddQuestionScreenState();
}

class _AddQuestionScreenState
    extends State<AddQuestionScreen> {
  final TextEditingController questionController =
      TextEditingController();

  final TextEditingController answerAController =
      TextEditingController();

  final TextEditingController answerBController =
      TextEditingController();

  final TextEditingController answerCController =
      TextEditingController();

  final TextEditingController answerDController =
      TextEditingController();

  String selectedCategory = 'PLN';

  int correctAnswer = 0;

  bool get isEdit =>
      widget.question != null;

  @override
  void initState() {
    super.initState();

    // =========================
    // ISI DATA JIKA EDIT
    // =========================

    if (widget.question != null) {
      final question = widget.question!;

      questionController.text =
          question['question'] ?? '';

      selectedCategory =
          question['category'] ?? 'PLN';

      final answers =
          List<String>.from(
        question['answers'] ?? [],
      );

      if (answers.length >= 4) {
        answerAController.text = answers[0];
        answerBController.text = answers[1];
        answerCController.text = answers[2];
        answerDController.text = answers[3];
      }

      correctAnswer =
          question['correct'] ?? 0;
    }
  }

  @override
  void dispose() {
    questionController.dispose();
    answerAController.dispose();
    answerBController.dispose();
    answerCController.dispose();
    answerDController.dispose();

    super.dispose();
  }

  // =========================
  // SIMPAN
  // =========================

  void saveQuestion() {
    if (questionController.text
            .trim()
            .isEmpty ||
        answerAController.text
            .trim()
            .isEmpty ||
        answerBController.text
            .trim()
            .isEmpty ||
        answerCController.text
            .trim()
            .isEmpty ||
        answerDController.text
            .trim()
            .isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Mohon lengkapi semua data soal!',
          ),
        ),
      );

      return;
    }

    // =========================
    // DATA SOAL
    // =========================

    final newQuestion = {
      'question':
          questionController.text.trim(),

      'category': selectedCategory,

      'answers': [
        answerAController.text.trim(),
        answerBController.text.trim(),
        answerCController.text.trim(),
        answerDController.text.trim(),
      ],

      'correct': correctAnswer,
    };

    // =========================
    // KEMBALIKAN DATA
    // =========================

    Navigator.pop(
      context,
      newQuestion,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F9FF),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFF00518A),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          isEdit
              ? 'Edit Soal'
              : 'Tambah Soal',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(
              maxWidth: 600,
            ),
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    isEdit
                        ? 'Edit Pertanyaan'
                        : 'Buat Pertanyaan Baru',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.w800,
                      color:
                          Color(0xFF00518A),
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Isi pertanyaan dan pilihan jawaban di bawah.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // =========================
                  // KATEGORI
                  // =========================

                  _buildLabel('Kategori'),

                  const SizedBox(height: 8),

                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    decoration:
                        BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(
                        14,
                      ),
                      border: Border.all(
                        color:
                            Colors.grey.shade200,
                      ),
                    ),
                    child:
                        DropdownButtonHideUnderline(
                      child:
                          DropdownButton<String>(
                        value:
                            selectedCategory,
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(
                            value: 'PLN',
                            child:
                                Text('PLN'),
                          ),
                          DropdownMenuItem(
                            value: 'Energi',
                            child:
                                Text('Energi'),
                          ),
                          DropdownMenuItem(
                            value:
                                'Kelistrikan',
                            child: Text(
                              'Kelistrikan',
                            ),
                          ),
                          DropdownMenuItem(
                            value:
                                'Pengetahuan',
                            child: Text(
                              'Pengetahuan',
                            ),
                          ),
                        ],
                        onChanged:
                            (value) {
                          if (value ==
                              null) {
                            return;
                          }

                          setState(() {
                            selectedCategory =
                                value;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // =========================
                  // PERTANYAAN
                  // =========================

                  _buildLabel(
                      'Pertanyaan'),

                  const SizedBox(height: 8),

                  TextField(
                    controller:
                        questionController,
                    maxLines: 4,
                    decoration:
                        _inputDecoration(
                      'Masukkan pertanyaan...',
                      Icons
                          .help_outline_rounded,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // =========================
                  // PILIHAN JAWABAN
                  // =========================

                  const Text(
                    'Pilihan Jawaban',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight:
                          FontWeight.w800,
                      color:
                          Color(0xFF123B58),
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'Pilih salah satu sebagai jawaban yang benar.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 15),

                  _buildAnswerField(
                    letter: 'A',
                    controller:
                        answerAController,
                    index: 0,
                  ),

                  const SizedBox(height: 12),

                  _buildAnswerField(
                    letter: 'B',
                    controller:
                        answerBController,
                    index: 1,
                  ),

                  const SizedBox(height: 12),

                  _buildAnswerField(
                    letter: 'C',
                    controller:
                        answerCController,
                    index: 2,
                  ),

                  const SizedBox(height: 12),

                  _buildAnswerField(
                    letter: 'D',
                    controller:
                        answerDController,
                    index: 3,
                  ),

                  const SizedBox(height: 30),

                  // =========================
                  // SIMPAN
                  // =========================

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child:
                        ElevatedButton.icon(
                      onPressed:
                          saveQuestion,
                      icon: const Icon(
                        Icons
                            .save_rounded,
                      ),
                      label: Text(
                        isEdit
                            ? 'Simpan Perubahan'
                            : 'Simpan Soal',
                        style:
                            const TextStyle(
                          fontSize: 15,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(
                          0xFF00518A,
                        ),
                        foregroundColor:
                            Colors.white,
                        elevation: 3,
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                            28,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // =========================
                  // BATAL
                  // =========================

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child:
                        OutlinedButton(
                      onPressed: () {
                        Navigator.pop(
                            context);
                      },
                      style:
                          OutlinedButton
                              .styleFrom(
                        foregroundColor:
                            const Color(
                          0xFF00518A,
                        ),
                        side:
                            const BorderSide(
                          color: Color(
                            0xFF00518A,
                          ),
                        ),
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                            28,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Batal',
                        style:
                            TextStyle(
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =========================
  // LABEL
  // =========================

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Color(0xFF123B58),
      ),
    );
  }

  // =========================
  // INPUT
  // =========================

  InputDecoration _inputDecoration(
    String hint,
    IconData icon,
  ) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(
        icon,
        color: const Color(0xFF00518A),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 15,
      ),
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
        borderSide: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      focusedBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFF00518A),
          width: 2,
        ),
      ),
    );
  }

  // =========================
  // ANSWER FIELD
  // =========================

  Widget _buildAnswerField({
    required String letter,
    required TextEditingController controller,
    required int index,
  }) {
    final bool selected =
        correctAnswer == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          correctAnswer = index;
        });
      },
      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 180),
        padding:
            const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFEAF5FC)
              : Colors.white,
          borderRadius:
              BorderRadius.circular(16),
          border: Border.all(
            color: selected
                ? const Color(0xFF00518A)
                : Colors.grey.shade200,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              alignment:
                  Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(
                        0xFF00518A)
                    : const Color(
                        0xFFF1F3F6),
                shape: BoxShape.circle,
              ),
              child: Text(
                letter,
                style: TextStyle(
                  fontWeight:
                      FontWeight.w800,
                  color: selected
                      ? Colors.white
                      : const Color(
                          0xFF555555),
                ),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: TextField(
                controller:
                    controller,
                decoration:
                    InputDecoration(
                  hintText:
                      'Jawaban $letter',
                  border:
                      InputBorder.none,
                  isDense: true,
                ),
              ),
            ),

            const SizedBox(width: 8),

            Icon(
              selected
                  ? Icons.check_circle
                  : Icons.circle_outlined,
              color: selected
                  ? Colors.green
                  : Colors.grey.shade400,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}