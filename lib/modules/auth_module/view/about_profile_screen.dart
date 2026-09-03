import 'package:flutter/material.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  TimeOfDay? wakeUpTime;
  TimeOfDay? sleepTime;

  String selectedGoal = 'Build Consistency';

  final List<String> goals = [
    'Build Consistency',
    'Improve Health',
    'Exercise Regularly',
    'Sleep Better',
    'Reduce Stress',
  ];

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(bool isWakeUp) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        if (isWakeUp) {
          wakeUpTime = picked;
        } else {
          sleepTime = picked;
        }
      });
    }
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) {
      return 'Select time';
    }

    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  void _continue() {
    if (nameController.text.trim().isEmpty) {
      _showMessage('Please enter your name');
      return;
    }

    if (ageController.text.trim().isEmpty) {
      _showMessage('Please enter your age');
      return;
    }

    if (wakeUpTime == null) {
      _showMessage('Please select your wake-up time');
      return;
    }

    if (sleepTime == null) {
      _showMessage('Please select your sleep time');
      return;
    }

    // Firebase save will be added here next.
    _showMessage('Profile details completed');

    // Next step:
    // Firebase save → HomeScreen
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 30 : 20,
              vertical: 30,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopIcon(),

                  const SizedBox(height: 28),

                  const Text(
                    'Tell us about you 👋',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF202336),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Help us personalize your daily habit experience.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF8A8FA3),
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 30),

                  _buildSectionCard(
                    title: 'Basic Information',
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: nameController,
                          label: 'Your Name',
                          hint: 'Enter your name',
                          icon: Icons.person_outline_rounded,
                        ),

                        const SizedBox(height: 16),

                        _buildTextField(
                          controller: ageController,
                          label: 'Age',
                          hint: 'Enter your age',
                          icon: Icons.cake_outlined,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  _buildSectionCard(
                    title: 'Your Routine',
                    child: Column(
                      children: [
                        _buildTimeTile(
                          title: 'Wake-up Time',
                          subtitle: _formatTime(wakeUpTime),
                          icon: Icons.wb_sunny_outlined,
                          onTap: () => _selectTime(true),
                        ),

                        const SizedBox(height: 12),

                        _buildTimeTile(
                          title: 'Sleep Time',
                          subtitle: _formatTime(sleepTime),
                          icon: Icons.bedtime_outlined,
                          onTap: () => _selectTime(false),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  _buildSectionCard(
                    title: 'Your Goal',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'What do you want to focus on?',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF8A8FA3),
                          ),
                        ),

                        const SizedBox(height: 14),

                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: goals.map((goal) {
                            final isSelected = selectedGoal == goal;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedGoal = goal;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 11,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF667EEA)
                                      : const Color(0xFFF5F6FA),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFF667EEA)
                                        : const Color(0xFFE5E6EC),
                                  ),
                                ),
                                child: Text(
                                  goal,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF555A6E),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _continue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF667EEA),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded, size: 20),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Center(
                    child: Text(
                      'You can update these details later from your profile.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11, color: Color(0xFF9A9EAE)),
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

  Widget _buildTopIcon() {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Icon(
        Icons.person_outline_rounded,
        color: Colors.white,
        size: 29,
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE7E8EE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF202336),
            ),
          ),
          const SizedBox(height: 17),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF555A6E),
          ),
        ),
        const SizedBox(height: 7),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFB0B3BF)),
            prefixIcon: Icon(icon, color: const Color(0xFF667EEA), size: 21),
            filled: true,
            fillColor: const Color(0xFFF8F9FC),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE8E9EF)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFF667EEA),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FC),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFE8E9EF)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F2FF),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(icon, color: const Color(0xFF667EEA), size: 22),
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
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF202336),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8A8FA3),
                    ),
                  ),
                ],
              ),
            ),

            const Icon(Icons.chevron_right_rounded, color: Color(0xFF9A9EAE)),
          ],
        ),
      ),
    );
  }
}
