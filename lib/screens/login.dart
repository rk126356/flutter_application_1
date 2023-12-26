import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    String errorMessage = '';

    if (phoneController.text.isEmpty || passwordController.text.isEmpty) {
      errorMessage = 'Please enter both Phone/Email and password';
      _showSnackbar(errorMessage);
      return;
    }

    const String apiUrl = 'https://gyanmeeti.in/API/student_login.php';
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'phone': phoneController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['message'] == 'Login successful') {
        // Login successful, update user data using the provider
        // ignore: use_build_context_synchronously
        Provider.of<UserProvider>(context, listen: false).updateUserData(
          newUserId: data['user'][0]['id'],
          newName: data['user'][0]['name'],
          newPhone: data['user'][0]['phone'],
          newEmail: data['user'][0]['email'],
        );

        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        // Login failed, display error message
        errorMessage = 'Login failed: ${data['message']}';
        _showSnackbar(errorMessage);
      }
    } else {
      // HTTP request failed, display error message
      errorMessage = 'HTTP request failed with status ${response.statusCode}';
      _showSnackbar(errorMessage);
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.deepPurple, Colors.indigo],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/login.png'),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone/Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: const Icon(Icons.person, color: Colors.white),
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Phone/Email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    textStyle: const TextStyle(color: Colors.deepPurple),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 120,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
