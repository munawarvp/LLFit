import 'package:flutter/material.dart';
import 'package:llfit_application/components/auth_button.dart';
import 'package:llfit_application/services/user.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool passwordVisible = true;

  void togglePasswordVisibility() {
    setState(() {
      passwordVisible = !passwordVisible; // Toggle the visibility
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.purple,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Get Started...',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 33,
                        fontFamily: 'Courier New')),
                const SizedBox(height: 20),
                TextField(
                  cursorColor: Colors.purple,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: const TextStyle(
                          color: Colors.white, fontFamily: 'Courier New'),
                      filled: true,
                      fillColor: Colors.purple[300],
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none))),
                ),
                const SizedBox(height: 20),
                TextField(
                  cursorColor: Colors.purple,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(
                          color: Colors.white, fontFamily: 'Courier New'),
                      filled: true,
                      fillColor: Colors.purple[300],
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none))),
                ),
                const SizedBox(height: 20),
                TextField(
                  obscureText: passwordVisible,
                  cursorColor: Colors.purple,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                          color: Colors.white, fontFamily: 'Courier New'),
                      filled: true,
                      fillColor: Colors.purple[300],
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none)),
                      suffixIcon: IconButton(
                          onPressed: () {
                            togglePasswordVisibility();
                          },
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ))),
                ),
                const SizedBox(height: 20),
                TextField(
                  cursorColor: Colors.purple,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: const TextStyle(
                          color: Colors.white, fontFamily: 'Courier New'),
                      filled: true,
                      fillColor: Colors.purple[300],
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none))),
                ),
                const SizedBox(height: 20),
                AuthButton(buttonText: 'Sign Up', buttonAction: () {})
              ],
            ),
          )),
    );
  }
}
