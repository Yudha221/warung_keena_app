import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:warung_keena_app/components/my_button.dart';
import 'package:warung_keena_app/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Logo
            SizedBox(
              width: 160,
              height: 150,
              child: SvgPicture.asset(
                'assets/icons/LogoWarung.svg',
                placeholderBuilder: (context) =>
                    const CircularProgressIndicator(),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            //message, app slogan
            const Text(
              "Let's create an account for you",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            //email textfield
            MyTextField(
              controller: emailController,
              hintText: 'email',
              obscureText: false,
            ),

            const SizedBox(
              height: 10,
            ),

            //password textfield
            MyTextField(
              controller: passwordController,
              hintText: 'password',
              obscureText: true,
            ),

            const SizedBox(
              height: 10,
            ),

            //password textfield
            MyTextField(
              controller: confirmPasswordController,
              hintText: 'confirm password',
              obscureText: true,
            ),

            const SizedBox(
              height: 10,
            ),

            //sign up button
            MyButton(
              text: 'Sign Up',
              onTap: () {}, // Diperbaiki
            ),

            const SizedBox(
              height: 25,
            ),

            //already have an account? Login here
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'already have an account?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'Login here',
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
