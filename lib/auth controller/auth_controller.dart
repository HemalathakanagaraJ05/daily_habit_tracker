// import 'package:daily_habit_tracker/models/view/home_screen.dart';
import 'package:daily_habit_tracker/models/view/home_screen.dart';
import 'package:daily_habit_tracker/models/view/register_scren.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final obscurePassword = true.obs;
  final isLoading = false.obs;

  void togglePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> login() async {
    try {
      isLoading.value = true;

      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      print('Login Success');
      print('UID: ${userCredential.user?.uid}');
      print('Email: ${userCredential.user?.email}');

      Get.offAll(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      print('Firebase Error Code: ${e.code}');

      if (e.code == 'invalid-email') {
        Get.snackbar(
          'Invalid Email',
          'Please enter a valid email address.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'user-not-found') {
        Get.snackbar(
          'Account Not Found',
          'No account found. Please create an account.',
          snackPosition: SnackPosition.BOTTOM,
        );

        await Future.delayed(const Duration(seconds: 2));

        Get.to(() => const RegisterScreen());
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          'Login Failed',
          'Incorrect password.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'invalid-credential') {
        Get.snackbar(
          'Login Failed',
          'Email or password is incorrect.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Login Failed',
          e.message ?? 'Something went wrong.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar(
        'Email Required',
        'Please enter your email address first.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);

      Get.snackbar(
        'Success',
        'Password reset email sent.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message ?? 'Unable to send reset email.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
