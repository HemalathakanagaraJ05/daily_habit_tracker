import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isDesktop ? 1000 : 700),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 40 : 20,
                vertical: 24,
              ),
              child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // MOBILE LAYOUT
  // ==========================================================

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 25),
        _buildProfileCard(),
        const SizedBox(height: 20),
        _buildStats(),
        const SizedBox(height: 28),
        _buildAccountSection(),
        const SizedBox(height: 25),
        _buildPreferencesSection(),
        const SizedBox(height: 25),
        _buildSupportSection(),
        const SizedBox(height: 25),
        _buildLogoutButton(),
        const SizedBox(height: 20),
      ],
    );
  }

  // ==========================================================
  // DESKTOP LAYOUT
  // ==========================================================

  Widget _buildDesktopLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 30),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  _buildProfileCard(),
                  const SizedBox(height: 20),
                  _buildStats(),
                ],
              ),
            ),

            const SizedBox(width: 25),

            Expanded(
              child: Column(
                children: [
                  _buildAccountSection(),
                  const SizedBox(height: 20),
                  _buildPreferencesSection(),
                  const SizedBox(height: 20),
                  _buildSupportSection(),
                  const SizedBox(height: 20),
                  _buildLogoutButton(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ==========================================================
  // HEADER
  // ==========================================================

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: Color(0xFF202336),
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Manage your account and preferences',
          style: TextStyle(fontSize: 14, color: Color(0xFF8A8FA3)),
        ),
      ],
    );
  }

  // ==========================================================
  // PROFILE CARD
  // ==========================================================

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667EEA).withOpacity(0.20),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.6),
                width: 3,
              ),
            ),
            child: const Center(
              child: Text(
                'H',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF667EEA),
                ),
              ),
            ),
          ),

          const SizedBox(width: 18),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hema',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'hema@example.com',
                  style: TextStyle(fontSize: 13, color: Colors.white70),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.verified_rounded, size: 16, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      'Habit Builder',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              _showEditProfileDialog();
            },
            icon: const Icon(Icons.edit_rounded, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // STATS
  // ==========================================================

  Widget _buildStats() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE8E9EF)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              icon: Icons.task_alt_rounded,
              value: '12',
              label: 'Habits',
            ),
          ),
          _buildVerticalDivider(),
          Expanded(
            child: _buildStatItem(
              icon: Icons.percent_rounded,
              value: '86%',
              label: 'Success',
            ),
          ),
          _buildVerticalDivider(),
          Expanded(
            child: _buildStatItem(
              icon: Icons.local_fire_department_rounded,
              value: '7',
              label: 'Streak',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, size: 22, color: const Color(0xFF667EEA)),
        const SizedBox(height: 7),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF202336),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFF8A8FA3)),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(height: 55, width: 1, color: const Color(0xFFE8E9EF));
  }

  // ==========================================================
  // ACCOUNT
  // ==========================================================

  Widget _buildAccountSection() {
    return _buildSectionCard(
      title: 'Account',
      children: [
        _buildMenuItem(
          icon: Icons.person_outline_rounded,
          title: 'Edit Profile',
          subtitle: 'Update your personal information',
          onTap: _showEditProfileDialog,
        ),
        _buildMenuItem(
          icon: Icons.lock_outline_rounded,
          title: 'Change Password',
          subtitle: 'Update your account password',
          onTap: () {
            _showMessage('Change Password');
          },
        ),
      ],
    );
  }

  // ==========================================================
  // PREFERENCES
  // ==========================================================

  Widget _buildPreferencesSection() {
    return _buildSectionCard(
      title: 'Preferences',
      children: [
        _buildSwitchItem(
          icon: Icons.notifications_none_rounded,
          title: 'Notifications',
          subtitle: 'Receive daily habit reminders',
          value: notificationsEnabled,
          onChanged: (value) {
            setState(() {
              notificationsEnabled = value;
            });
          },
        ),
        _buildSwitchItem(
          icon: Icons.dark_mode_outlined,
          title: 'Dark Mode',
          subtitle: 'Use dark appearance',
          value: darkModeEnabled,
          onChanged: (value) {
            setState(() {
              darkModeEnabled = value;
            });

            _showMessage(value ? 'Dark Mode enabled' : 'Dark Mode disabled');
          },
        ),
      ],
    );
  }

  // ==========================================================
  // SUPPORT
  // ==========================================================

  Widget _buildSupportSection() {
    return _buildSectionCard(
      title: 'Support',
      children: [
        _buildMenuItem(
          icon: Icons.help_outline_rounded,
          title: 'Help & Support',
          subtitle: 'Get help with Daily Habit',
          onTap: () {
            _showMessage('Help & Support');
          },
        ),
        _buildMenuItem(
          icon: Icons.info_outline_rounded,
          title: 'About',
          subtitle: 'Daily Habit Tracker v1.0.0',
          onTap: () {
            _showAboutDialog();
          },
        ),
      ],
    );
  }

  // ==========================================================
  // SECTION CARD
  // ==========================================================

  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE8E9EF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Color(0xFF202336),
            ),
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  // ==========================================================
  // MENU ITEM
  // ==========================================================

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F1FF),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(icon, color: const Color(0xFF667EEA), size: 21),
            ),

            const SizedBox(width: 13),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF303347),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9A9EAE),
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFB0B3BF),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // SWITCH ITEM
  // ==========================================================

  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F1FF),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: const Color(0xFF667EEA), size: 21),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF303347),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF9A9EAE),
                  ),
                ),
              ],
            ),
          ),

          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF667EEA),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // LOGOUT
  // ==========================================================

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: _showLogoutDialog,
        icon: const Icon(
          Icons.logout_rounded,
          size: 20,
          color: Colors.redAccent,
        ),
        label: const Text(
          'Logout',
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFFFD6D6)),
          backgroundColor: const Color(0xFFFFF8F8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // EDIT PROFILE
  // ==========================================================

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: 'Hema');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Edit Profile',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showMessage('Profile updated');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF667EEA),
                foregroundColor: Colors.white,
              ),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // LOGOUT DIALOG
  // ==========================================================

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Logout?',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                _showMessage('Logged out');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // ABOUT
  // ==========================================================

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'Daily Habit',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.check_circle_rounded, color: Colors.white),
      ),
      children: const [Text('Build better habits. Become better you.')],
    );
  }

  // ==========================================================
  // MESSAGE
  // ==========================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
