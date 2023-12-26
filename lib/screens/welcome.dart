import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:flutter_application_1/screens/register.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the user provider to check if the user is logged in
    UserProvider userProvider = Provider.of<UserProvider>(context);

    // Check if the user is already logged in
    if (userProvider.isLoggedIn) {
      // If logged in, navigate to the home screen
      return const HomeScreen();
    }

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/welcome.png',
            width: 400,
          ),
          const Center(
            child: Text(
              'Welcome To Our Application',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 22,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.new_label),
              label: const Text('Register'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.login),
              label: const Text('Login'),
            ),
          ),
          const SizedBox(
            height: 22,
          ),
        ],
      ),
    );
  }
}
