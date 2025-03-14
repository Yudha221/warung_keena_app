import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:warung_keena_app/components/my_button.dart';
import 'package:warung_keena_app/components/my_textfield.dart';
import 'package:warung_keena_app/pages/home/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Login method
  void login() {
    // Navigasi ke DashboardPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DashboardPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            SizedBox(
              width: 160,
              height: 150,
              child: SvgPicture.asset(
                'assets/icons/LogoWarung.svg',
                placeholderBuilder: (context) =>
                    const CircularProgressIndicator(),
              ),
            ),
            const SizedBox(height: 10),

            // Slogan
            const Text(
              'Warung Keena POS',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),

            // Email textfield
            MyTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
            ),
            const SizedBox(height: 10),

            // Password textfield
            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),

            const SizedBox(height: 10),

            // Sign in button
            MyButton(
              text: 'Sign In',
              onTap: login, // Diperbaiki
            ),

            const SizedBox(height: 25),

            // Not a member? Register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Not a member?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
