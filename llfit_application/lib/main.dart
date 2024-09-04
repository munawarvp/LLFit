import 'package:flutter/material.dart';
import 'package:llfit_application/screens/home_screen.dart';
import 'package:llfit_application/screens/login_screen.dart';
import 'package:llfit_application/screens/signup_screen.dart';
import 'package:llfit_application/services/provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderDemo(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 83, 76, 175),
      ),
      home: const HomeScreen(),
      routes: {
        '/home-screen': (context) => const HomeScreen(),
        '/login-screen': (context) => const LoginScreen(),
        '/signup-screen': (context) => const SignupScreen(),
      },
      ),
    );
  }
}
