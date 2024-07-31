import 'package:flutter/material.dart';
import 'package:llfit_application/components/bottom_bar.dart';
import 'package:llfit_application/services/user.dart';


class ProfileScreen extends StatefulWidget {
  final String token;
  final Future<dynamic> profile;

  const ProfileScreen({
    super.key,
    required this.token,
    required this.profile
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: ', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}