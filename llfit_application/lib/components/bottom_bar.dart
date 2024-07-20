import 'package:flutter/material.dart';
import 'package:llfit_application/screens/home_screen.dart';
import 'package:llfit_application/screens/profile_screen.dart';


class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.purple,
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: SizedBox(
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pushNamed('/home-screen');
              },
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pushNamed('/login-screen');
              },
            ),
            IconButton(
              icon: const Icon(Icons.access_alarm, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pushNamed('/signup-screen');
              },
            ),
            IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pushNamed('/profile-screen');
              },
            ),
          ],
        ),
      ),
    );
  }
}