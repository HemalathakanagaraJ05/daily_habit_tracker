import 'package:daily_habit_tracker/models/view/add_habite_screen.dart';
import 'package:daily_habit_tracker/models/view/statistics_Screen.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    StatisticsScreen(),
    AddHabitScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  final List<String> titles = const [
    'Home',
    'Statistics',
    'Add Habit',
    'History',
    'Profile',
  ];

  final List<IconData> icons = const [
    Icons.home_rounded,
    Icons.bar_chart_rounded,
    Icons.add_task_rounded,
    Icons.calendar_month_rounded,
    Icons.person_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool isDesktop = width >= 900;

    if (isDesktop) {
      return _buildDesktopLayout();
    }

    return _buildMobileLayout();
  }

  // ==========================================================
  // MOBILE / TABLET
  // ==========================================================

  Widget _buildMobileLayout() {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),

      body: IndexedStack(index: selectedIndex, children: screens),

      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  // ==========================================================
  // BOTTOM NAVIGATION
  // ==========================================================

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(icons.length, (index) {
              return _buildNavigationItem(index);
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationItem(int index) {
    final bool isSelected = selectedIndex == index;

    // Special Add Habit button
    if (index == 2) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF667EEA).withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 27,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              'Add',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? const Color(0xFF667EEA)
                    : const Color(0xFF8A8FA3),
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0F1FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icons[index],
              size: 23,
              color: isSelected
                  ? const Color(0xFF667EEA)
                  : const Color(0xFF8A8FA3),
            ),
            const SizedBox(height: 3),
            Text(
              titles[index],
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF667EEA)
                    : const Color(0xFF8A8FA3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // DESKTOP / WEB
  // ==========================================================

  Widget _buildDesktopLayout() {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),

      body: Row(
        children: [
          _buildSideNavigation(),

          Expanded(
            child: IndexedStack(index: selectedIndex, children: screens),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // SIDE NAVIGATION
  // ==========================================================

  Widget _buildSideNavigation() {
    return Container(
      width: 245,
      decoration: const BoxDecoration(color: Colors.white),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 25),

            // Logo
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                ),
                borderRadius: BorderRadius.circular(17),
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'Daily Habit',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202336),
              ),
            ),

            const SizedBox(height: 40),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  return _buildSideNavigationItem(index);
                },
              ),
            ),

            // Bottom profile
            Container(
              margin: const EdgeInsets.all(14),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8FC),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        'H',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hema',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF202336),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Keep going!',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF8A8FA3),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.more_vert_rounded,
                    size: 20,
                    color: Color(0xFF8A8FA3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSideNavigationItem(int index) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0F1FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(
              icons[index],
              size: 21,
              color: isSelected
                  ? const Color(0xFF667EEA)
                  : const Color(0xFF8A8FA3),
            ),

            const SizedBox(width: 13),

            Text(
              titles[index],
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF667EEA)
                    : const Color(0xFF626679),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
