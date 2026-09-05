import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_habit_tracker/modules/auth_module/view/botton_appbar_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  bool isLoading = false;

  TimeOfDay? wakeUpTime;
  TimeOfDay? sleepTime;

  String? nameError;
  String? ageError;
  String? wakeUpError;
  String? sleepError;

  String selectedGoal = 'Build Consistency';

  final List<String> goals = [
    'Build Consistency',
    'Improve Health',
    'Exercise Regularly',
    'Sleep Better',
    'Reduce Stress',
  ];

  @override
  void initState() {
    super.initState();

    nameController.addListener(() {
      if (nameError != null && nameController.text.trim().isNotEmpty) {
        setState(() {
          nameError = null;
        });
      }
    });

    ageController.addListener(() {
      if (ageError != null && ageController.text.trim().isNotEmpty) {
        setState(() {
          ageError = null;
        });
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  // =========================
  // SELECT TIME
  // =========================

  Future<void> _selectTime(bool isWakeUp) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        if (isWakeUp) {
          wakeUpTime = picked;
          wakeUpError = null;
        } else {
          sleepTime = picked;
          sleepError = null;
        }
      });
    }
  }

  // =========================
  // FORMAT TIME
  // =========================

  String _formatTime(TimeOfDay? time) {
    if (time == null) {
      return 'Select time';
    }

    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  // =========================
  // CONTINUE / VALIDATION
  // =========================

  Future<void> _continue() async {
    // Clear old errors
    setState(() {
      nameError = null;
      ageError = null;
      wakeUpError = null;
      sleepError = null;
    });

    bool isValid = true;

    // Name validation
    if (nameController.text.trim().isEmpty) {
      nameError = 'Please enter your name';
      isValid = false;
    }

    // Age validation
    if (ageController.text.trim().isEmpty) {
      ageError = 'Please enter your age';
      isValid = false;
    } else {
      final int? age = int.tryParse(ageController.text.trim());

      if (age == null) {
        ageError = 'Please enter a valid age';
        isValid = false;
      } else if (age < 1 || age > 100) {
        ageError = 'Age must be between 1 and 100';
        isValid = false;
      }
    }

    // Wake-up validation
    if (wakeUpTime == null) {
      wakeUpError = 'Please select your wake-up time';
      isValid = false;
    }

    // Sleep validation
    if (sleepTime == null) {
      sleepError = 'Please select your sleep time';
      isValid = false;
    }

    // Stop if validation failed
    if (!isValid) {
      setState(() {});
      return;
    }

    // =========================
    // GET CURRENT USER
    // =========================

    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      _showMessage('User session not found. Please login again.');
      return;
    }

    // =========================
    // START LOADING
    // =========================

    setState(() {
      isLoading = true;
    });

    try {
      // =========================
      // SAVE TO FIRESTORE
      // =========================

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'name': nameController.text.trim(),
        'email': user.email ?? '',
        'age': int.parse(ageController.text.trim()),
        'wakeUpTime': _formatTime(wakeUpTime),
        'sleepTime': _formatTime(sleepTime),
        'dailyGoal': selectedGoal,
        'profileCompleted': true,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      if (!mounted) return;

      // =========================
      // STOP LOADING
      // =========================

      setState(() {
        isLoading = false;
      });

      // =========================
      // GO TO HOME
      // =========================

      Get.to(() => const BottomScreen());
    } on FirebaseException catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      _showMessage(e.message ?? 'Unable to save profile.');
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      _showMessage('Something went wrong. Please try again.');
    }
  }
  // =========================
  // SNACKBAR
  // =========================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // =========================
  // BUILD
  // =========================

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
                  // =========================
                  // TOP ICON
                  // =========================
                  _buildTopIcon(),

                  const SizedBox(height: 28),

                  // =========================
                  // TITLE
                  // =========================
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

                  // =========================
                  // BASIC INFORMATION
                  // =========================
                  _buildSectionCard(
                    title: 'Basic Information',
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: nameController,
                          label: 'Your Name',
                          hint: 'Enter your name',
                          icon: Icons.person_outline_rounded,
                          errorText: nameError,
                        ),

                        const SizedBox(height: 16),

                        _buildTextField(
                          controller: ageController,
                          label: 'Age',
                          hint: 'Enter your age',
                          icon: Icons.cake_outlined,
                          keyboardType: TextInputType.number,
                          errorText: ageError,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // =========================
                  // YOUR ROUTINE
                  // =========================
                  _buildSectionCard(
                    title: 'Your Routine',
                    child: Column(
                      children: [
                        _buildTimeTile(
                          title: 'Wake-up Time',
                          subtitle: _formatTime(wakeUpTime),
                          icon: Icons.wb_sunny_outlined,
                          onTap: () => _selectTime(true),
                          errorText: wakeUpError,
                        ),

                        const SizedBox(height: 12),

                        _buildTimeTile(
                          title: 'Sleep Time',
                          subtitle: _formatTime(sleepTime),
                          icon: Icons.bedtime_outlined,
                          onTap: () => _selectTime(false),
                          errorText: sleepError,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // =========================
                  // YOUR GOAL
                  // =========================
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
                            final bool isSelected = selectedGoal == goal;

                            return GestureDetector(
                              onTap: isLoading
                                  ? null
                                  : () {
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

                  // =========================
                  // CONTINUE BUTTON
                  // =========================
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _continue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF667EEA),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: const Color(0xFF667EEA),
                        disabledForegroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              width: 23,
                              height: 23,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Row(
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

                  // =========================
                  // FOOTER TEXT
                  // =========================
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

  // =========================
  // TOP ICON
  // =========================

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

  // =========================
  // SECTION CARD
  // =========================

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

  // =========================
  // TEXT FIELD
  // =========================

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? errorText,
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
            errorText: errorText,
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  // =========================
  // TIME TILE
  // =========================

  Widget _buildTimeTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: isLoading ? null : onTap,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FC),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: errorText != null ? Colors.red : const Color(0xFFE8E9EF),
              ),
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

                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF9A9EAE),
                ),
              ],
            ),
          ),
        ),

        if (errorText != null) ...[
          const SizedBox(height: 6),

          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              errorText,
              style: const TextStyle(fontSize: 12, color: Colors.red),
            ),
          ),
        ],
      ],
    );
  }
}
