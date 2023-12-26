import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/user_provider.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String errorMessage = '';

  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      const String apiUrl = 'https://gyanmeeti.in/API/student_register.php';
      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          body: {
            'name': nameController.text,
            'phone': phoneController.text,
            'email': emailController.text,
            'password': passwordController.text,
          },
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);

          if (data['message'] == 'Registration Successful') {
            setState(() {
              errorMessage = '';
            });

            print('Registration successful: ${data['message']}');

            // Update user data using the provider
            Provider.of<UserProvider>(context, listen: false).updateUserData(
              newUserId: '0',
              newName: nameController.text,
              newPhone: phoneController.text,
              newEmail: emailController.text,
            );

            Navigator.pop(context);
          } else {
            setState(() {
              errorMessage = 'Registration failed: ${data['message']}';
            });
            _showSnackbar(errorMessage);
          }
        } else {
          setState(() {
            errorMessage =
                'HTTP request failed with status ${response.statusCode}';
          });
          _showSnackbar(errorMessage);
        }
      } catch (error) {
        setState(() {
          errorMessage = 'Error: $error';
        });
        _showSnackbar(errorMessage);
      }
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
          'Register',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon:
                        const Icon(Icons.person, color: Colors.deepPurple),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon:
                        const Icon(Icons.phone, color: Colors.deepPurple),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 9) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon:
                        const Icon(Icons.email, color: Colors.deepPurple),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Please enter a valid email address';
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
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon:
                        const Icon(Icons.lock, color: Colors.deepPurple),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    textStyle: const TextStyle(color: Colors.white),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
