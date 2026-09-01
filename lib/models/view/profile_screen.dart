import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF7F8FC),
      body: Center(
        child: Text(
          'Profile',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
