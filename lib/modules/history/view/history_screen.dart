import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

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
          'History',
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
              constraints: BoxConstraints(maxWidth: isDesktop ? 900 : 700),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildDateCard(),
                  const SizedBox(height: 20),
                  _buildHistoryList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Activity History',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Color(0xFF202336),
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Review your completed habits and daily progress.',
          style: TextStyle(fontSize: 14, color: Color(0xFF8A8FA3)),
        ),
      ],
    );
  }

  Widget _buildDateCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE7E8EE)),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F2FF),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.calendar_month_outlined,
              color: Color(0xFF667EEA),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF202336),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'September 3, 2026',
                  style: TextStyle(fontSize: 12, color: Color(0xFF8A8FA3)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF8F0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '4 / 5 Done',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2E9B61),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    final history = [
      {
        'date': 'Today',
        'day': 'Sep 3',
        'completed': '4 of 5 habits completed',
        'percentage': '80%',
        'icon': Icons.today_outlined,
      },
      {
        'date': 'Yesterday',
        'day': 'Sep 2',
        'completed': '5 of 5 habits completed',
        'percentage': '100%',
        'icon': Icons.check_circle_outline_rounded,
      },
      {
        'date': 'Tuesday',
        'day': 'Sep 1',
        'completed': '4 of 5 habits completed',
        'percentage': '80%',
        'icon': Icons.calendar_today_outlined,
      },
      {
        'date': 'Monday',
        'day': 'Aug 31',
        'completed': '3 of 5 habits completed',
        'percentage': '60%',
        'icon': Icons.calendar_today_outlined,
      },
      {
        'date': 'Sunday',
        'day': 'Aug 30',
        'completed': '5 of 5 habits completed',
        'percentage': '100%',
        'icon': Icons.check_circle_outline_rounded,
      },
      {
        'date': 'Saturday',
        'day': 'Aug 29',
        'completed': '2 of 5 habits completed',
        'percentage': '40%',
        'icon': Icons.calendar_today_outlined,
      },
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
            'Recent Activity',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF202336),
            ),
          ),
          const SizedBox(height: 18),
          ...history.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            return Column(
              children: [
                _historyItem(
                  date: item['date'] as String,
                  day: item['day'] as String,
                  completed: item['completed'] as String,
                  percentage: item['percentage'] as String,
                  icon: item['icon'] as IconData,
                ),
                if (index != history.length - 1)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(height: 1, color: Color(0xFFEDEEF3)),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _historyItem({
    required String date,
    required String day,
    required String completed,
    required String percentage,
    required IconData icon,
  }) {
    final isComplete = percentage == '100%';

    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isComplete
                ? const Color(0xFFEAF8F0)
                : const Color(0xFFF0F2FF),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: isComplete
                ? const Color(0xFF2E9B61)
                : const Color(0xFF667EEA),
            size: 23,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF202336),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    day,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9A9EAF),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                completed,
                style: const TextStyle(fontSize: 12, color: Color(0xFF8A8FA3)),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: isComplete
                ? const Color(0xFFEAF8F0)
                : const Color(0xFFF5F6FA),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            percentage,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isComplete
                  ? const Color(0xFF2E9B61)
                  : const Color(0xFF667EEA),
            ),
          ),
        ),
      ],
    );
  }
}
