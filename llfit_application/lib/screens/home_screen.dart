import 'package:flutter/material.dart';
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
    return const Scaffold(
      body: Center(
        child: Text('Home Screen'),
      ),
      bottomNavigationBar: BottomBar()
    );
  }
}