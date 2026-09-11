import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  final List<Map<String, dynamic>> players = const [
    {
      'rank': 1,
      'name': 'Andi',
      'score': 100,
    },
    {
      'rank': 2,
      'name': 'Budi',
      'score': 90,
    },
    {
      'rank': 3,
      'name': 'Citra',
      'score': 80,
    },
    {
      'rank': 4,
      'name': 'Dimas',
      'score': 70,
    },
    {
      'rank': 5,
      'name': 'Eka',
      'score': 60,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF00518A),
        foregroundColor: Colors.white,
        title: const Text(
          'Leaderboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [

                // =========================
                // JUDUL
                // =========================

                const Text(
                  '🏆 Peringkat Terbaik',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF123B58),
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Lihat siapa yang mendapatkan skor tertinggi!',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 25),

                // =========================
                // TOP 3
                // =========================

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // JUARA 2
                    _buildTopPlayer(
                      name: players[1]['name'],
                      score: players[1]['score'],
                      rank: 2,
                      height: 160,
                    ),

                    const SizedBox(width: 10),

                    // JUARA 1
                    _buildTopPlayer(
                      name: players[0]['name'],
                      score: players[0]['score'],
                      rank: 1,
                      height: 170,
                    ),

                    const SizedBox(width: 10),

                    // JUARA 3
                    _buildTopPlayer(
                      name: players[2]['name'],
                      score: players[2]['score'],
                      rank: 3,
                      height: 150,
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // =========================
                // DAFTAR PERINGKAT
                // =========================

                ...players.map(
                  (player) => Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 13,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [

                        // RANK
                        Container(
                          width: 38,
                          height: 38,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF5FC),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${player['rank']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00518A),
                            ),
                          ),
                        ),

                        const SizedBox(width: 13),

                        // NAMA
                        Expanded(
                          child: Text(
                            player['name'],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        // SCORE
                        Text(
                          '${player['score']}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1769E0),
                          ),
                        ),

                        const SizedBox(width: 5),

                        const Text(
                          'poin',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
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
      ),
    );
  }

  Widget _buildTopPlayer({
    required String name,
    required int score,
    required int rank,
    required double height,
  }) {
    return Container(
      width: 105,
      height: height,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(
            rank == 1
                ? '🥇'
                : rank == 2
                    ? '🥈'
                    : '🥉',
            style: const TextStyle(
              fontSize: 30,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            '$score',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1769E0),
            ),
          ),
        ],
      ),
    );
  }
}