import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> habits = [
    {
      'title': 'Drink Water',
      'subtitle': '8 glasses',
      'icon': Icons.water_drop_rounded,
      'completed': true,
    },
    {
      'title': 'Morning Exercise',
      'subtitle': '30 minutes',
      'icon': Icons.fitness_center_rounded,
      'completed': false,
    },
    {
      'title': 'Read a Book',
      'subtitle': '20 pages',
      'icon': Icons.menu_book_rounded,
      'completed': false,
    },
    {
      'title': 'Meditation',
      'subtitle': '10 minutes',
      'icon': Icons.self_improvement_rounded,
      'completed': false,
    },
  ];

  int get completedCount {
    return habits.where((habit) => habit['completed'] == true).length;
  }

  double get progress {
    if (habits.isEmpty) return 0;
    return completedCount / habits.length;
  }

  void toggleHabit(int index) {
    setState(() {
      habits[index]['completed'] = !habits[index]['completed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-habit');
        },
        backgroundColor: const Color(0xFF667EEA),
        elevation: 5,
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
      ),
    );
  }

  // ----------------------------------------------------------
  // MOBILE
  // ----------------------------------------------------------

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildProgressCard(),
          const SizedBox(height: 24),
          _buildStats(),
          const SizedBox(height: 28),
          _buildSectionTitle(),
          const SizedBox(height: 14),
          _buildHabitList(),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // DESKTOP / WEB
  // ----------------------------------------------------------

  Widget _buildDesktopLayout() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 30),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: _buildProgressCard()),
                  const SizedBox(width: 20),
                  Expanded(child: _buildStats()),
                ],
              ),

              const SizedBox(height: 35),

              _buildSectionTitle(),

              const SizedBox(height: 16),

              _buildHabitGrid(),
            ],
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // HEADER
  // ----------------------------------------------------------

  Widget _buildHeader() {
    final hour = DateTime.now().hour;

    String greeting;

    if (hour < 12) {
      greeting = 'Good Morning';
    } else if (hour < 17) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF8A8FA3),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Hello, Hema 👋',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF202336),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                _formattedDate(),
                style: const TextStyle(fontSize: 14, color: Color(0xFF8A8FA3)),
              ),
            ],
          ),
        ),

        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: Color(0xFF202336),
          ),
        ),

        const SizedBox(width: 12),

        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
            ),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              'H',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ----------------------------------------------------------
  // PROGRESS CARD
  // ----------------------------------------------------------

  Widget _buildProgressCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667EEA).withOpacity(0.25),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Today\'s Progress',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Today',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          Row(
            children: [
              SizedBox(
                width: 105,
                height: 105,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 9,
                        backgroundColor: Colors.white.withOpacity(0.15),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    ),

                    Text(
                      '${(progress * 100).round()}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 25),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$completedCount of ${habits.length} habits',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      progress == 1
                          ? 'Amazing! All done 🎉'
                          : 'Keep going, you are doing great!',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 7,
              backgroundColor: Colors.white.withOpacity(0.15),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // STATS
  // ----------------------------------------------------------

  Widget _buildStats() {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            icon: Icons.local_fire_department_rounded,
            value: '7',
            label: 'Day Streak',
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: _statCard(
            icon: Icons.emoji_events_rounded,
            value: '12',
            label: 'Best Streak',
          ),
        ),
      ],
    );
  }

  Widget _statCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F1FF),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: const Color(0xFF667EEA), size: 23),
          ),

          const SizedBox(height: 16),

          Text(
            value,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: Color(0xFF202336),
            ),
          ),

          const SizedBox(height: 3),

          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF8A8FA3)),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // SECTION TITLE
  // ----------------------------------------------------------

  Widget _buildSectionTitle() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Today\'s Habits',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF202336),
            ),
          ),
        ),

        TextButton(
          onPressed: () {},
          child: const Text(
            'View All',
            style: TextStyle(
              color: Color(0xFF667EEA),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // ----------------------------------------------------------
  // HABIT LIST - MOBILE
  // ----------------------------------------------------------

  Widget _buildHabitList() {
    return Column(
      children: List.generate(habits.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _habitCard(index),
        );
      }),
    );
  }

  // ----------------------------------------------------------
  // HABIT GRID - WEB
  // ----------------------------------------------------------

  Widget _buildHabitGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: habits.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 3.4,
      ),
      itemBuilder: (context, index) {
        return _habitCard(index);
      },
    );
  }

  // ----------------------------------------------------------
  // HABIT CARD
  // ----------------------------------------------------------

  Widget _habitCard(int index) {
    final habit = habits[index];
    final bool completed = habit['completed'];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: completed
              ? const Color(0xFF667EEA).withOpacity(0.25)
              : Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: completed
                  ? const Color(0xFFE9EAFF)
                  : const Color(0xFFF5F6FA),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              habit['icon'],
              color: completed
                  ? const Color(0xFF667EEA)
                  : const Color(0xFF85899B),
              size: 24,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  habit['title'],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: completed
                        ? const Color(0xFF8A8FA3)
                        : const Color(0xFF202336),
                    decoration: completed ? TextDecoration.lineThrough : null,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  habit['subtitle'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9A9EAE),
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () {
              toggleHabit(index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: completed ? const Color(0xFF667EEA) : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: completed
                      ? const Color(0xFF667EEA)
                      : const Color(0xFFD5D7E0),
                  width: 2,
                ),
              ),
              child: completed
                  ? const Icon(
                      Icons.check_rounded,
                      size: 19,
                      color: Colors.white,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // ADD HABIT DIALOG
  // ----------------------------------------------------------

  // void _showAddHabitDialog() {
  //   final TextEditingController controller = TextEditingController();

  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(24),
  //         ),
  //         title: const Text(
  //           'Add New Habit',
  //           style: TextStyle(fontWeight: FontWeight.w700),
  //         ),
  //         content: TextField(
  //           controller: controller,
  //           decoration: InputDecoration(
  //             hintText: 'Enter habit name',
  //             filled: true,
  //             fillColor: const Color(0xFFF6F7FA),
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(14),
  //               borderSide: BorderSide.none,
  //             ),
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               if (controller.text.trim().isNotEmpty) {
  //                 setState(() {
  //                   habits.add({
  //                     'title': controller.text.trim(),
  //                     'subtitle': 'New habit',
  //                     'icon': Icons.check_circle_outline_rounded,
  //                     'completed': false,
  //                   });
  //                 });

  //                 Navigator.pop(context);
  //               }
  //             },
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: const Color(0xFF667EEA),
  //               foregroundColor: Colors.white,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(12),
  //               ),
  //             ),
  //             child: const Text('Add Habit'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // ----------------------------------------------------------
  // DATE
  // ----------------------------------------------------------

  String _formattedDate() {
    final now = DateTime.now();

    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${months[now.month - 1]} ${now.day}, ${now.year}';
  }
}
