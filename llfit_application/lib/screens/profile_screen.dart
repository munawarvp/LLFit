import 'package:flutter/material.dart';
import 'package:llfit_application/components/bottom_bar.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Welcome to the Profile Screen!'),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

}