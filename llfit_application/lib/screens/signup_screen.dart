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

   final _usernameController = TextEditingController();
   final _emailController = TextEditingController();
   final _passwordController = TextEditingController();

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
                const Text('Signup',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 33,)),
                const SizedBox(height: 20),
                TextField(
                  controller: _usernameController,
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
                  controller: _emailController,
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
                  controller: _passwordController,
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
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Already have an account?",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      // const Text('Signup', style: TextStyle(color: Colors.white, fontSize: 18)),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/login-screen');
                          },
                          child: const Text('Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)))
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                AuthButton(buttonText: 'Signup', buttonAction: () {
                  registerUser(context, {});
                })
              ],
            ),
          )),
    );
  }
}
