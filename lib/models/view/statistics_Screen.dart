import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Statistics',
          style: TextStyle(
            color: Color(0xFF202336),
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF202336)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: isDesktop ? 1000 : 700),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),

                  const SizedBox(height: 22),

                  _buildStatsCards(isDesktop),

                  const SizedBox(height: 24),

                  _buildWeeklyChart(),

                  const SizedBox(height: 24),

                  _buildHabitPerformance(),

                  const SizedBox(height: 24),

                  _buildStreakCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // HEADER
  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Progress',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Color(0xFF202336),
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Track your habit progress and stay consistent.',
          style: TextStyle(fontSize: 14, color: Color(0xFF8A8FA3)),
        ),
      ],
    );
  }

  // STAT CARDS
  Widget _buildStatsCards(bool isDesktop) {
    final cards = [
      _statCard(
        icon: Icons.check_circle_outline_rounded,
        title: 'Completed',
        value: '24',
        subtitle: 'This week',
      ),
      _statCard(
        icon: Icons.local_fire_department_outlined,
        title: 'Current Streak',
        value: '7',
        subtitle: 'Days',
      ),
      _statCard(
        icon: Icons.track_changes_rounded,
        title: 'Completion',
        value: '82%',
        subtitle: 'This week',
      ),
    ];

    if (isDesktop) {
      return Row(
        children: [
          Expanded(child: cards[0]),
          const SizedBox(width: 14),
          Expanded(child: cards[1]),
          const SizedBox(width: 14),
          Expanded(child: cards[2]),
        ],
      );
    }

    return Column(
      children: [
        cards[0],
        const SizedBox(height: 14),
        cards[1],
        const SizedBox(height: 14),
        cards[2],
      ],
    );
  }

  Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE7E8EE)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F2FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: const Color(0xFF667EEA), size: 25),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF8A8FA3),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF202336),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF8A8FA3),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // WEEKLY CHART
  Widget _buildWeeklyChart() {
    final data = [
      {'day': 'Mon', 'value': 0.65},
      {'day': 'Tue', 'value': 0.80},
      {'day': 'Wed', 'value': 0.50},
      {'day': 'Thu', 'value': 0.90},
      {'day': 'Fri', 'value': 0.75},
      {'day': 'Sat', 'value': 0.95},
      {'day': 'Sun', 'value': 0.82},
    ];

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
          const Text(
            'Weekly Progress',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF202336),
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Your habit completion for the last 7 days',
            style: TextStyle(fontSize: 13, color: Color(0xFF8A8FA3)),
          ),

          const SizedBox(height: 25),

          SizedBox(
            height: 220,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: data.map((item) {
                final value = item['value'] as double;
                final day = item['day'] as String;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${(value * 100).round()}%',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF667EEA),
                      ),
                    ),

                    const SizedBox(height: 6),

                    Container(
                      width: 25,
                      height: 150 * value,
                      decoration: BoxDecoration(
                        color: const Color(0xFF667EEA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      day,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF8A8FA3),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // HABIT PERFORMANCE
  Widget _buildHabitPerformance() {
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
          const Text(
            'Habit Performance',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF202336),
            ),
          ),

          const SizedBox(height: 18),

          _habitItem(
            icon: Icons.water_drop_outlined,
            name: 'Drink Water',
            completed: 6,
            total: 7,
            percentage: 0.86,
          ),

          const SizedBox(height: 18),

          _habitItem(
            icon: Icons.menu_book_outlined,
            name: 'Read a Book',
            completed: 5,
            total: 7,
            percentage: 0.71,
          ),

          const SizedBox(height: 18),

          _habitItem(
            icon: Icons.fitness_center_outlined,
            name: 'Exercise',
            completed: 4,
            total: 7,
            percentage: 0.57,
          ),

          const SizedBox(height: 18),

          _habitItem(
            icon: Icons.self_improvement_outlined,
            name: 'Meditation',
            completed: 7,
            total: 7,
            percentage: 1.0,
          ),
        ],
      ),
    );
  }

  Widget _habitItem({
    required IconData icon,
    required String name,
    required int completed,
    required int total,
    required double percentage,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F2FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFF667EEA), size: 21),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF202336),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    '$completed of $total days completed',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF8A8FA3),
                    ),
                  ),
                ],
              ),
            ),

            Text(
              '${(percentage * 100).round()}%',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF667EEA),
              ),
            ),
          ],
        ),

        const SizedBox(height: 9),

        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 7,
            backgroundColor: const Color(0xFFEDEEF4),
            valueColor: const AlwaysStoppedAnimation(Color(0xFF667EEA)),
          ),
        ),
      ],
    );
  }

  // STREAK
  Widget _buildStreakCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.local_fire_department_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),

          const SizedBox(width: 16),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Keep Going! 🔥',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'You are on a 7 day streak. Keep building your habits!',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),

          const Text(
            '7',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
