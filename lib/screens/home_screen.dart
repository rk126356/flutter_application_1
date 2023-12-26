import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/welcome.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';
import '../widgets/build_user_info_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the user provider to get user information
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Logout logic, clear user data and navigate to login screen
              userProvider.updateUserData(
                newUserId: '',
                newName: '',
                newPhone: '',
                newEmail: '',
              );

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const WelcomeScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple, Colors.indigo],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'User Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 12),
                  buildUserInfo('Name', userProvider.user.name),
                  buildUserInfo('Phone', userProvider.user.phone),
                  buildUserInfo('Email', userProvider.user.email),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
