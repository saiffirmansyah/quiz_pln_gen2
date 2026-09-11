import 'package:flutter/material.dart';
import 'add_question_screen.dart';
import '../data/questions.dart';

class ManageQuestionsScreen extends StatefulWidget {
  const ManageQuestionsScreen({super.key});

  @override
  State<ManageQuestionsScreen> createState() =>
      _ManageQuestionsScreenState();
}

class _ManageQuestionsScreenState
    extends State<ManageQuestionsScreen> {
  String searchText = '';
  String selectedCategory = 'Semua';

  // =========================
  // FILTER SOAL
  // =========================

  List<Map<String, dynamic>> get filteredQuestions {
    return questions.where((question) {
      final matchesSearch = question['question']
          .toString()
          .toLowerCase()
          .contains(searchText.toLowerCase());

      final matchesCategory =
          selectedCategory == 'Semua' ||
          question['category'] == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  // =========================
  // TAMBAH SOAL
  // =========================

  Future<void> addQuestion() async {
    final newQuestion = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddQuestionScreen(),
      ),
    );

    if (newQuestion != null) {
      setState(() {
        questions.add(
          Map<String, dynamic>.from(newQuestion),
        );
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Soal berhasil ditambahkan! 🎉',
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  // =========================
  // HAPUS SOAL
  // =========================

  void deleteQuestion(int index) {
    final question = filteredQuestions[index];

    final originalIndex = questions.indexOf(question);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Soal?'),
          content: const Text(
            'Apakah kamu yakin ingin menghapus soal ini?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  questions.removeAt(originalIndex);
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Soal berhasil dihapus.',
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  // =========================
  // EDIT SOAL
  // =========================

  Future<void> editQuestion(int index) async {
    final question = filteredQuestions[index];

    final originalIndex = questions.indexOf(question);

    final updatedQuestion = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddQuestionScreen(
          question: Map<String, dynamic>.from(question),
        ),
      ),
    );

    if (updatedQuestion != null) {
      setState(() {
        questions[originalIndex] =
            Map<String, dynamic>.from(updatedQuestion);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Soal berhasil diperbarui! ✅',
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),

      // =========================
      // APP BAR
      // =========================

      appBar: AppBar(
        backgroundColor: const Color(0xFF00518A),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Kelola Keseruan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // =========================
      // BODY
      // =========================

      body: Column(
        children: [
          // =========================
          // SEARCH & FILTER
          // =========================

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari soal...',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF00518A),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      categoryChip('Semua'),
                      categoryChip('PLN'),
                      categoryChip('Energi'),
                      categoryChip('Kelistrikan'),
                      categoryChip('Pengetahuan'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // =========================
          // JUMLAH SOAL
          // =========================

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              children: [
                Text(
                  '${filteredQuestions.length} Soal',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00518A),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // =========================
          // LIST
          // =========================

          Expanded(
            child: filteredQuestions.isEmpty
                ? const Center(
                    child: Text(
                      'Soal tidak ditemukan',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredQuestions.length,
                    itemBuilder: (context, index) {
                      final question =
                          filteredQuestions[index];

                      return questionCard(
                        question,
                        index,
                      );
                    },
                  ),
          ),
        ],
      ),

      // =========================
      // TAMBAH SOAL
      // =========================

      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: addQuestion,
        backgroundColor: const Color(0xFF00518A),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text(
          'Tambah Soal',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // =========================
  // CATEGORY CHIP
  // =========================

  Widget categoryChip(String category) {
    final active =
        selectedCategory == category;

    return Padding(
      padding:
          const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(category),
        selected: active,
        onSelected: (_) {
          setState(() {
            selectedCategory = category;
          });
        },
        selectedColor:
            const Color(0xFF00518A),
        labelStyle: TextStyle(
          color: active
              ? Colors.white
              : Colors.black87,
          fontWeight: active
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
    );
  }

  // =========================
  // QUESTION CARD
  // =========================

  Widget questionCard(
    Map<String, dynamic> question,
    int index,
  ) {
    return Card(
      margin:
          const EdgeInsets.only(bottom: 12),
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            // CATEGORY
            Container(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color:
                    const Color(0xFFE5F3FB),
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: Text(
                question['category'],
                style: const TextStyle(
                  color:
                      Color(0xFF00518A),
                  fontSize: 11,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // SOAL
            Text(
              question['question'],
              style: const TextStyle(
                fontSize: 15,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // JAWABAN
            ...List.generate(
              question['answers'].length,
              (answerIndex) {
                final isCorrect =
                    answerIndex ==
                        question['correct'];

                return Padding(
                  padding:
                      const EdgeInsets.only(
                    bottom: 5,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isCorrect
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        size: 16,
                        color: isCorrect
                            ? Colors.green
                            : Colors.grey,
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: Text(
                          question['answers']
                              [answerIndex],
                          style: TextStyle(
                            fontSize: 12,
                            color: isCorrect
                                ? Colors.green
                                : Colors.black87,
                            fontWeight: isCorrect
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 8),

            // BUTTON
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    editQuestion(index);
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 18,
                  ),
                  label:
                      const Text('Edit'),
                ),

                TextButton.icon(
                  onPressed: () {
                    deleteQuestion(index);
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 18,
                    color: Colors.red,
                  ),
                  label: const Text(
                    'Hapus',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}