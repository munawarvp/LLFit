import 'package:flutter/material.dart';
import 'package:llfit_application/screens/profile_screen.dart';
import 'package:llfit_application/components/bottom_bar.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Welcome to the Home Screen!'),
      ),
      bottomNavigationBar: BottomBar()
    );
  }
}