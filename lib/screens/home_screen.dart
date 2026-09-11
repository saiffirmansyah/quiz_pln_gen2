import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import 'leaderboard_screen.dart';
import 'profile_screen.dart';
import 'manage_questions_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),

      body: SafeArea(
        child: Column(
          children: [

            // =========================
            // HEADER
            // =========================

            Container(
              height: 65,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF00518A),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Row(
                children: [

                  // Logo kecil
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: const Icon(
                      Icons.bolt_rounded,
                      color: Color(0xFF00518A),
                    ),
                  ),

                  const SizedBox(width: 10),

                  const Text(
                    'E-Quiz',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                ],
              ),
            ),

            // =========================
            // CONTENT
            // =========================

            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 30,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 500,
                    ),
                    child: Column(
                      children: [

                        // =========================
                        // LOGO
                        // =========================

                        Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(35),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF00518A)
                                    .withOpacity(0.15),
                                blurRadius: 25,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(35),
                            child: Image.asset(
                              'assets/images/logo_quiz.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),

                        // =========================
                        // TITLE
                        // =========================

                        const Text(
                          'Halo, Insan PLN!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF004B80),
                          ),
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          'Siap untuk Seru-seruan?',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 30),

                        // =========================
                        // MULAI MAIN
                        // =========================

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const QuizScreen(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.play_arrow_rounded,
                            ),
                            label: const Text(
                              'Mulai Main',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF00518A),
                              foregroundColor: Colors.white,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // =========================
                        // LEADERBOARD
                        // =========================

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const LeaderboardScreen(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.bar_chart_rounded,
                            ),
                            label: const Text(
                              'Lihat Leaderboard',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFFFFD000),
                              foregroundColor:
                                  const Color(0xFF333333),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(30),
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

                    const SizedBox(height: 14),

                    // KELOLA KESERUAN
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                const ManageQuestionsScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.edit_note_rounded,
                        ),
                        label: const Text(
                          'Kelola Keseruan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF00518A),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          side: const BorderSide(
                            color: Color(0xFF00518A),
                          ),
                        ),            
                      ),
                    ),

            // =========================
            // BOTTOM NAVIGATION
            // =========================

            Container(
              height: 68,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                children: [

                  // PLAY
                  _NavItem(
                    icon: Icons.play_circle_rounded,
                    label: 'Play',
                    active: true,
                    onTap: () {
                      // Sudah berada di halaman Home
                    },
                  ),

                  // LEADERBOARD
                  _NavItem(
                    icon: Icons.leaderboard_rounded,
                    label: 'Leaderboard',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LeaderboardScreen(),
                        ),
                      );
                    },
                  ),

                  // PROFILE
                  _NavItem(
                    icon: Icons.person_rounded,
                    label: 'Profile',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfileScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================================================
// BOTTOM NAVIGATION ITEM
// ==================================================

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback? onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    this.active = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 100,
        height: 68,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              icon,
              size: 21,
              color: active
                  ? const Color(0xFF00518A)
                  : Colors.grey,
            ),

            const SizedBox(height: 3),

            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                fontWeight:
                    active ? FontWeight.bold : FontWeight.normal,
                color: active
                    ? const Color(0xFF00518A)
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}