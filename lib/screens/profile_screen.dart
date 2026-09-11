import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),

      // =========================
      // HEADER
      // =========================

      appBar: AppBar(
        backgroundColor: const Color(0xFF00518A),
        foregroundColor: Colors.white,
        title: const Text(
          'Profile',
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [

                  // =========================
                  // PROFILE HEADER
                  // =========================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00518A),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [

                        // FOTO PROFILE
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFFFD000),
                              width: 4,
                            ),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 50,
                            color: Color(0xFF00518A),
                          ),
                        ),

                        const SizedBox(height: 15),

                        const Text(
                          'Insan PLN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          'Peserta E-Quiz PLN',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // =========================
                  // STATISTIK
                  // =========================

                  Row(
                    children: [

                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.emoji_events,
                          value: '100',
                          label: 'Skor Tertinggi',
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.games,
                          value: '5',
                          label: 'Quiz Dimainkan',
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.star,
                          value: '420',
                          label: 'Total Poin',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // =========================
                  // MENU
                  // =========================

                  _buildMenuItem(
                    icon: Icons.person_outline,
                    title: 'Informasi Profile',
                    subtitle: 'Lihat informasi akun',
                    onTap: () {},
                  ),

                  _buildMenuItem(
                    icon: Icons.settings_outlined,
                    title: 'Pengaturan',
                    subtitle: 'Atur preferensi aplikasi',
                    onTap: () {},
                  ),

                  _buildMenuItem(
                    icon: Icons.help_outline,
                    title: 'Bantuan',
                    subtitle: 'Butuh bantuan?',
                    onTap: () {},
                  ),

                  _buildMenuItem(
                    icon: Icons.logout,
                    title: 'Keluar',
                    subtitle: 'Keluar dari akun',
                    iconColor: Colors.red,
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'E-Quiz PLN v1.0.0',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
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

  // =========================
  // STAT CARD
  // =========================

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 5,
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
      child: Column(
        children: [

          Icon(
            icon,
            color: const Color(0xFF1769E0),
            size: 25,
          ),

          const SizedBox(height: 7),

          Text(
            value,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1769E0),
            ),
          ),

          const SizedBox(height: 3),

          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // MENU ITEM
  // =========================

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color iconColor = const Color(0xFF00518A),
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),

        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),

        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),

        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.grey,
        ),

        onTap: onTap,
      ),
    );
  }

  // =========================
  // LOGOUT DIALOG
  // =========================

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Keluar'),
          content: const Text(
            'Apakah kamu yakin ingin keluar?',
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
                Navigator.pop(context);
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }
}