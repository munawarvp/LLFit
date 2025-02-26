import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:llfit_application/components/bottom_bar.dart';
import 'package:llfit_application/screens/login_screen.dart';
import 'package:llfit_application/components/workout_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoggedIn = false;
  String? username;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  // Function to check if token is present in SharedPreferences
  Future<void> _checkIfLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final loggedInUser = prefs.getString('username');

    if (token == null || token.isEmpty) {
      // If no token found, redirect to login screen (you can replace with your own logic)
      Navigator.pushReplacementNamed(context, '/login-screen');
    } else {
      setState(() {
        _isLoggedIn = true;
        username = loggedInUser;
      });
    }
  }

  Future<void> signout(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) =>
            const LoginScreen())); // Navigate to login screen after signout
  }

  @override
  Widget build(BuildContext context) {
    final String currentDay = DateFormat('EEEE').format(DateTime.now()); // Get current day
    return Scaffold(
      body: _isLoggedIn
          ? SafeArea(
            child: Column(
                children: [
                  // Box displaying the current day
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0), // Adjust padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi $username,',
                          style: const TextStyle(
                            fontSize: 25, // Slightly reduced font size
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 19, 46, 93), // Contrast text color
                          ),
                        ),
                        Text(
                          currentDay, // Display the current day
                          style: const TextStyle(
                            fontSize: 20, // Slightly reduced font size
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent, // Contrast text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: WorkoutList()),
                ],
              ),
          )
          : const Center(
              child:
                  CircularProgressIndicator()), // Show loading if token check is in progress
      bottomNavigationBar: const BottomBar(),
    );
  }
}
