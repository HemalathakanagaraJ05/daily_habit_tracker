import 'package:daily_habit_tracker/auth%20controller/auth_controller.dart';
import 'package:daily_habit_tracker/models/view/register_scren.dart';
// import 'package:daily_habit_tracker/models/view/botton_appbar_Screen.dart';
// import 'package:daily_habit_tracker/models/view/register_scren.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginController controller = Get.put(LoginController());
  bool obscurePassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: isDesktop ? 450 : 500),
              child: _buildLoginCard(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
              ),
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF667EEA).withOpacity(0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
              size: 42,
            ),
          ),
        ),

        const SizedBox(height: 28),

        const Center(
          child: Text(
            'Welcome Back 👋',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFF202336),
            ),
          ),
        ),

        const SizedBox(height: 8),

        const Center(
          child: Text(
            'Login to continue building better habits.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Color(0xFF8A8FA3)),
          ),
        ),

        const SizedBox(height: 35),

        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Email Address',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF202336),
                ),
              ),

              const SizedBox(height: 9),

              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration(
                  hint: 'Enter your email',
                  icon: Icons.email_outlined,
                ),
                validator: (value) {
                  print('email ID: Please enter your email');
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }

                  final email = value.trim();

                  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
                  print(' email id :$email');

                  if (!emailRegex.hasMatch(email)) {
                    return 'Please enter a valid Gmail address';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF202336),
                ),
              ),

              const SizedBox(height: 9),

              Obx(
                () => TextFormField(
                  controller: controller.passwordController,
                  obscureText: controller.obscurePassword.value,
                  decoration: _inputDecoration(
                    hint: 'Enter your password',
                    icon: Icons.lock_outline_rounded,
                    suffix: IconButton(
                      onPressed: controller.togglePassword,
                      icon: Icon(
                        controller.obscurePassword.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: const Color(0xFF8A8FA3),
                      ),
                    ),
                  ),
                  validator: (value) {
                    print('password: Please enter your password');
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    print('password length: ${value.length}');
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: controller.forgotPassword,
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xFF667EEA),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              controller.login();
                            }
                          },
                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 23,
                            height: 23,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        Row(
          children: [
            const Expanded(child: Divider(color: Color(0xFFE1E2E8))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'OR',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
            ),
            const Expanded(child: Divider(color: Color(0xFFE1E2E8))),
          ],
        ),

        const SizedBox(height: 25),

        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.g_mobiledata_rounded,
              size: 28,
              color: Color(0xFF202336),
            ),
            label: const Text(
              'Continue with Google',
              style: TextStyle(
                color: Color(0xFF202336),
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFE1E2E8)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),

        const SizedBox(height: 28),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Don\'t have an account? ',
              style: TextStyle(color: Color(0xFF8A8FA3), fontSize: 13),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => RegisterScreen());
              },
              child: const Text(
                'Create Account',
                style: TextStyle(
                  color: Color(0xFF667EEA),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFFA0A3B1), fontSize: 14),
      prefixIcon: Icon(icon, color: const Color(0xFF667EEA)),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE7E8EE)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF667EEA), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }
}
