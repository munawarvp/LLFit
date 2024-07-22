import 'package:flutter/material.dart';
import 'package:llfit_application/screens/profile_screen.dart';
import 'package:llfit_application/components/bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> signout () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: () async {
          await signout();
        }, child: Icon(Icons.exit_to_app)),
      ),
      bottomNavigationBar: BottomBar()
    );
  }
}