import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:warung_keena_app/components/my_button.dart';
import 'package:warung_keena_app/components/my_textfield.dart';
import 'package:warung_keena_app/components/square_tile.dart';
import 'package:warung_keena_app/pages/home/dashboard_page.dart'; // Import halaman Dashboard

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn(BuildContext context) {
    // Navigasi ke halaman dashboard setelah login sukses
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // logo
              SizedBox(
                width: 160,
                height: 150,
                child: SvgPicture.asset(
                  'assets/icons/LogoWarung.svg',
                  semanticsLabel: 'Warung Keena Logo',
                  placeholderBuilder: (context) =>
                      const CircularProgressIndicator(),
                ),
              ),

              // welcome back, you've been missed!
              const Text(
                'Warung Keena',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 25),

              // email textfield
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                onTap: () =>
                    signUserIn(context), // Panggil fungsi dengan context
              ),

              const SizedBox(height: 60),
              // google + apple sign in buttons
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  SquareTile(imagePath: 'assets/images/google.png'),

                  SizedBox(width: 25),
                ],
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
