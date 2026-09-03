import 'package:flutter/material.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final TextEditingController habitController = TextEditingController();
  final TextEditingController goalController = TextEditingController();

  String selectedCategory = 'Health';
  String selectedFrequency = 'Daily';

  TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 0);

  final List<Map<String, dynamic>> categories = [
    {'name': 'Health', 'icon': Icons.favorite_rounded},
    {'name': 'Fitness', 'icon': Icons.fitness_center_rounded},
    {'name': 'Study', 'icon': Icons.menu_book_rounded},
    {'name': 'Personal', 'icon': Icons.person_rounded},
  ];

  @override
  void dispose() {
    habitController.dispose();
    goalController.dispose();
    super.dispose();
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _createHabit() {
    if (habitController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a habit name')),
      );
      return;
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F8FC),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: Color(0xFF202336),
          ),
        ),
        title: const Text(
          'Add New Habit',
          style: TextStyle(
            color: Color(0xFF202336),
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isDesktop ? 850 : 600),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 30 : 20,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIntro(),
                  const SizedBox(height: 25),

                  _buildSectionTitle('Habit Name'),
                  const SizedBox(height: 10),
                  _buildHabitNameField(),

                  const SizedBox(height: 25),

                  _buildSectionTitle('Category'),
                  const SizedBox(height: 12),
                  _buildCategories(),

                  const SizedBox(height: 25),

                  _buildSectionTitle('Frequency'),
                  const SizedBox(height: 12),
                  _buildFrequency(),

                  const SizedBox(height: 25),

                  _buildSectionTitle('Daily Goal'),
                  const SizedBox(height: 10),
                  _buildGoalField(),

                  const SizedBox(height: 25),

                  _buildSectionTitle('Reminder'),
                  const SizedBox(height: 10),
                  _buildReminder(),

                  const SizedBox(height: 35),

                  _buildCreateButton(),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // INTRO
  // ----------------------------------------------------------

  Widget _buildIntro() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(17),
            ),
            child: const Icon(
              Icons.add_task_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),

          const SizedBox(width: 15),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create a new habit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Small steps every day create big changes.',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // SECTION TITLE
  // ----------------------------------------------------------

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF202336),
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  // ----------------------------------------------------------
  // HABIT NAME
  // ----------------------------------------------------------

  Widget _buildHabitNameField() {
    return TextField(
      controller: habitController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: 'e.g. Drink Water',
        hintStyle: const TextStyle(color: Color(0xFF9A9EAE), fontSize: 14),
        prefixIcon: const Icon(Icons.edit_rounded, color: Color(0xFF667EEA)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 17,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // CATEGORIES
  // ----------------------------------------------------------

  Widget _buildCategories() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: categories.map((category) {
        final bool selected = selectedCategory == category['name'];

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedCategory = category['name'];
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: selected ? const Color(0xFF667EEA) : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: selected
                    ? const Color(0xFF667EEA)
                    : const Color(0xFFE7E8EE),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  category['icon'],
                  size: 18,
                  color: selected ? Colors.white : const Color(0xFF667EEA),
                ),
                const SizedBox(width: 7),
                Text(
                  category['name'],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : const Color(0xFF505469),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // ----------------------------------------------------------
  // FREQUENCY
  // ----------------------------------------------------------

  Widget _buildFrequency() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(child: _frequencyButton('Daily')),
          Expanded(child: _frequencyButton('Weekly')),
        ],
      ),
    );
  }

  Widget _frequencyButton(String value) {
    final bool selected = selectedFrequency == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFrequency = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF667EEA) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            value,
            style: TextStyle(
              color: selected ? Colors.white : const Color(0xFF777B8E),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // GOAL
  // ----------------------------------------------------------

  Widget _buildGoalField() {
    return TextField(
      controller: goalController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'e.g. 8',
        hintStyle: const TextStyle(color: Color(0xFF9A9EAE), fontSize: 14),
        prefixIcon: const Icon(Icons.flag_rounded, color: Color(0xFF667EEA)),
        suffixText: 'times',
        suffixStyle: const TextStyle(color: Color(0xFF8A8FA3), fontSize: 13),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 17,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // REMINDER
  // ----------------------------------------------------------

  Widget _buildReminder() {
    return GestureDetector(
      onTap: _selectTime,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F1FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.notifications_active_rounded,
                color: Color(0xFF667EEA),
                size: 20,
              ),
            ),

            const SizedBox(width: 13),

            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daily Reminder',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF202336),
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Tap to choose reminder time',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9A9EAE)),
                  ),
                ],
              ),
            ),

            Text(
              selectedTime.format(context),
              style: const TextStyle(
                color: Color(0xFF667EEA),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(width: 5),

            const Icon(Icons.chevron_right_rounded, color: Color(0xFF9A9EAE)),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // CREATE BUTTON
  // ----------------------------------------------------------

  Widget _buildCreateButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _createHabit,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF667EEA),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_rounded, size: 22),
            SizedBox(width: 8),
            Text(
              'Create Habit',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
