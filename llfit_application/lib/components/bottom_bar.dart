import 'package:flutter/material.dart';
import 'package:llfit_application/screens/home_screen.dart';
import 'package:llfit_application/screens/profile_screen.dart';
import 'package:llfit_application/services/user.dart';
import 'package:llfit_application/utils/config.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: baseColor,
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
                if (ModalRoute.of(context)?.settings.name != '/home-screen') {
                  Navigator.of(context).pushNamed('/home-screen');
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.currency_rupee, color: Colors.white),
              onPressed: () async {
                await checkToken(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.movie_filter, color: Colors.white),
              onPressed: () {
                // Navigator.of(context).pushNamed('/signup-screen');
              },
            ),
            IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name != '/profile-screen') {
                  Navigator.of(context).pushNamed('/profile-screen');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
