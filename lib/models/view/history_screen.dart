import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF7F8FC),
      body: Center(
        child: Text(
          'History',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
