import 'package:daily_habit_tracker/models/view/botton_appbar_Screen.dart';
// import 'package:daily_habit_tracker/models/view/home_screen.dart';
import 'package:daily_habit_tracker/models/view/register_scren.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // TEXT CONTROLLERS
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // OBSERVABLE VALUES
  final obscurePassword = true.obs;
  final isLoading = false.obs;

  // PASSWORD VISIBILITY
  void togglePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  // LOGIN
  Future<void> login() async {
    try {
      isLoading.value = true;

      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      print('========== LOGIN START ==========');
      print('Email: $email');
      print('Password Length: ${password.length}');

      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      print('========== LOGIN SUCCESS ==========');
      print('UID: ${user?.uid}');
      print('Email: ${user?.email}');
      print('===================================');

      // HOME SCREEN
      Get.offAll(() => const MainNavigationScreen());
    } on FirebaseAuthException catch (e) {
      print('========== FIREBASE LOGIN ERROR ==========');
      print('Error Code: ${e.code}');
      print('Error Message: ${e.message}');
      print('==========================================');

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
      } else if (e.code == 'user-disabled') {
        Get.snackbar(
          'Account Disabled',
          'This account has been disabled.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'too-many-requests') {
        Get.snackbar(
          'Too Many Attempts',
          'Please try again later.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Login Failed',
          e.message ?? 'Something went wrong.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('========== LOGIN UNKNOWN ERROR ==========');
      print(e);
      print('=========================================');

      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // FORGOT PASSWORD
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
      print('Forgot Password Error: ${e.code}');

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
