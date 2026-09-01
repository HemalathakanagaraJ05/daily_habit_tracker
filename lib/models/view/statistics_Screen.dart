import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF7F8FC),
      body: Center(
        child: Text(
          'Statistics',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
