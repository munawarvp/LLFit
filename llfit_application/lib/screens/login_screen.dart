import 'package:flutter/material.dart';
import 'package:llfit_application/components/auth_button.dart';
import 'package:llfit_application/services/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkToken();
  }

  bool passwordVisible = true;

  final _usernameController = TextEditingController();
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset('assets/logo/LLFit.png', width: 100, height: 100),
            const SizedBox(height: 20),
            const Text('Welcome back...',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 33,
                    fontFamily: 'Courier New')),
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
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none))),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: passwordVisible,
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                      color: Colors.white, fontFamily: 'Courier New'),
                  filled: true,
                  fillColor: Colors.purple[300],
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      togglePasswordVisibility();
                    },
                  )),
            ),
            const SizedBox(height: 20),
            AuthButton(
                buttonText: 'Login',
                buttonAction: () {loginUser(context, {'username': _usernameController.text, 'password': _passwordController.text});}
              )
          ],
        ),
      ),
    ));
  }
}
